package utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public final class Bank {
    public List<BankAccount> accounts_list;
    private static final int THREADS = 10;
    private static final int ACCOUNTS = 100;
    private static final long OPERATIONS = 50000;
    private static final long OPERATIONS_PER_THREAD = OPERATIONS / THREADS;
    public Lock mutex = new ReentrantLock();
    private boolean check_flag = false;

    public Bank() {
        accounts_list = new ArrayList<>();
    }

    private void createAccounts() {
        int account_id = 0;
        for (int i = 0; i < ACCOUNTS; ++i) {
            accounts_list.add(new BankAccount(account_id++, 200));
        }
    }

    public void run() {
        createAccounts();
        float start = System.nanoTime() / 1000000;

        List<Thread> threads = new ArrayList<>();
        for (int i = 0; i < THREADS; i++) {
            int executedThread = i;
            threads.add(new Thread(() -> {
                Random r = new Random();
                for (long j = 0; j < OPERATIONS_PER_THREAD; ++j) {
                    int accId = r.nextInt(ACCOUNTS);
                    int accId2 = r.nextInt(ACCOUNTS);
                    if (accId == accId2) {
                        --j;
                        continue;
                    }
                    int sum = r.nextInt(50);
                    accounts_list.get(accId).makeTransfer(accounts_list.get(accId2), sum);
                    System.out.println("Thread " + executedThread + ": sent $" + sum + " from account: " + accId + " to account:" + accId2);
                }
            }));
        }

        threads.forEach(Thread::start);

        Thread checker = new Thread(() -> {
            mutex.lock();
            while (!check_flag) {
                mutex.unlock();
                Random r = new Random();
                if (r.nextInt(5) == 0) {
                    runCorrectnessCheck();
                }
                mutex.lock();
            }
            mutex.unlock();
        });

        threads.forEach(thread -> {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        mutex.lock();
        check_flag = true;
        mutex.unlock();

        checker.start();

        try {
            checker.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        runCorrectnessCheck();

        float end = System.nanoTime() / 1000000;

        System.out.println("Time elapsed: " + (end - start) / 1000 + " seconds");
    }

    private void runCorrectnessCheck() {
        System.out.println("The Correctness Check Started:");
        AtomicInteger failedAccounts = new AtomicInteger();

        for (BankAccount account : accounts_list) {
            account.mutex.lock();
            try {
                if (!account.consistencyCheck()) {
                    failedAccounts.getAndIncrement();
                }
            } finally {
                account.mutex.unlock();
            }
        }

        for (BankAccount account : accounts_list) {
            int targetAccountId;
            account.mutex.lock();

            try {
                for (BankAccount.Operation op : account.operation_log) {
                    targetAccountId = op.destination_account;
                    BankAccount targetAccount = accounts_list.get(targetAccountId);
                    if (account.account_id < targetAccount.account_id) {
                        account.mutex.unlock();
                        targetAccount.mutex.lock();
                        try {
                            if (!targetAccount.operation_log.contains(new BankAccount.Operation("RECEIVE", targetAccount.account_id, account.account_id, op.amount, op.timestamp))) {
                                failedAccounts.getAndIncrement();
                            }
                        } finally {
                            targetAccount.mutex.unlock();
                        }
                        account.mutex.lock();
                    } else {
                        targetAccount.mutex.lock();
                        account.mutex.unlock();
                        try {
                            if (!targetAccount.operation_log.contains(new BankAccount.Operation("RECEIVE", targetAccount.account_id, account.account_id, op.amount, op.timestamp))) {
                                failedAccounts.getAndIncrement();
                            }
                        } finally {
                            targetAccount.mutex.unlock();
                        }
                        account.mutex.lock();
                    }
                }
            } finally {
                account.mutex.unlock();
            }
        }

        if (failedAccounts.get() > 0) {
            throw new RuntimeException("Accounts no longer consistent!");
        }
        System.out.println("Check ended, failed accounts: " + failedAccounts);
    }

    @Override
    public String toString() {
        return "Bank{" +
                "accounts=" + accounts_list +
                '}';
    }
}
