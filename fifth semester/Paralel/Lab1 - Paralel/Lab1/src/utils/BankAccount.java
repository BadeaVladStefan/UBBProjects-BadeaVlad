package utils;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public final class BankAccount {
    public int account_id;
    public int account_balance;
    public int initial_account_balance;
    public Lock mutex;
    public List<Operation> operation_log;

    public BankAccount(int account_id, int account_balance) {
        this.account_id = account_id;
        this.initial_account_balance = account_balance;
        this.account_balance = account_balance;
        this.mutex = new ReentrantLock();
        this.operation_log = new ArrayList<>();
    }

    public boolean makeTransfer(BankAccount other, int sum) {
        if (this.account_id < other.account_id) {
            this.mutex.lock();
            other.mutex.lock();
        } else {
            other.mutex.lock();
            this.mutex.lock();
        }

        try {
            if (sum <= 0 || sum > account_balance) {
                System.out.printf("Account: %d is to poor to send account: %d the sum of $%d.%n", this.account_id, sum, account_balance);
                return false;
            }

            account_balance -= sum;
            other.account_balance += sum;
            long timestamp = System.currentTimeMillis();

            logTransfer("SEND", this.account_id, other.account_id, sum, timestamp);
            other.logTransfer("RECEIVE", other.account_id, this.account_id, sum, timestamp);

        } finally {
            this.mutex.unlock();
            other.mutex.unlock();
        }

        return true;
    }

    public void logTransfer(String type, int source, int destination, int sum, long timestamp) {
        operation_log.add(new Operation(type, source, destination, sum, timestamp));
    }

    public boolean consistencyCheck() {
        int computed_balance = this.initial_account_balance;
        for (Operation operation : operation_log) {
            if (operation.operation_type.equals("SEND"))
                computed_balance -= operation.amount;
            else
                computed_balance += operation.amount;
        }
        return computed_balance == this.account_balance;
    }

    static class Operation {
        String operation_type;
        int source_account;
        int destination_account;
        int amount;
        long timestamp;

        public Operation(String operation_type, int source_account, int destination_account, int amount, long timestamp) {
            this.operation_type = operation_type;
            this.source_account = source_account;
            this.destination_account = destination_account;
            this.amount = amount;
            this.timestamp = timestamp;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Operation operation = (Operation) o;
            return source_account == operation.source_account && destination_account == operation.destination_account &&
                    amount == operation.amount && timestamp == operation.timestamp;
        }
    }
}
