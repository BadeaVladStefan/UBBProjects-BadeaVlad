import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class Main {
    public static void main(String[] args) {
        int matrixSize = 20;
        Matrix matrix1 = new Matrix(matrixSize, matrixSize);
        Matrix matrix2 = new Matrix(matrixSize, matrixSize);

        matrix1.populateMatrix(1, 10);
        matrix2.populateMatrix(1, 10);

        // print the matrices
        System.out.println("Matrix 1:");
        System.out.println(matrix1);
        System.out.println("Matrix 2:");
        System.out.println(matrix2);

        int numberOfTasks = 6;

        // perform matrix multiplication using kth approach and measure performance
        System.out.println("Matrix multiplication using k-th tasks:");
        Matrix resultKthTasks = multiplyUsingKthTasks(matrix1, matrix2, numberOfTasks);
        System.out.println("Result using k-th tasks:");
        System.out.println(resultKthTasks);

        // perform matrix multiplication using thread pools and kth approach and measure performance
        System.out.println("Matrix multiplication using k-th tasks with ThreadPool:");
        Matrix resultKthTasksThreadPool = multiplyUsingKthTasksThreadPool(matrix1, matrix2, numberOfTasks);
        System.out.println("Result using k-th tasks with ThreadPool:");
        System.out.println(resultKthTasksThreadPool);

        if (resultKthTasks.equals(resultKthTasksThreadPool)) {
            System.out.println("Both methods produced the same result.");
        } else {
            System.out.println("The results differ between the two methods.");
        }
    }

    public static Matrix multiplyUsingKthTasks(Matrix matrix1, Matrix matrix2, int numberOfTasks) {
        long startTime = System.currentTimeMillis();

        Integer[][] resultingMatrix = new Integer[matrix1.getNumberOfRows()][matrix2.getNumberOfColumns()];
        Thread[] threads = new Thread[numberOfTasks];

        for (int index = 0; index < numberOfTasks; index++) {
            threads[index] = new Thread(new KthTask(resultingMatrix, matrix1, matrix2, index, numberOfTasks));
            threads[index].start();
        }

        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException exception) {
                System.out.println(exception.getMessage());
            }
        }

        long endTime = System.currentTimeMillis();
        System.out.println("K-th tasks took " + (endTime - startTime) + " milliseconds");

        return new Matrix(resultingMatrix);
    }



    public static Matrix multiplyUsingKthTasksThreadPool(Matrix matrix1, Matrix matrix2, int numberOfTasks) {
        long startTime = System.currentTimeMillis();
        int poolSize = numberOfTasks/3;

        Integer[][] resultingMatrix = new Integer[matrix1.getNumberOfRows()][matrix2.getNumberOfColumns()];
        ExecutorService executorService = Executors.newFixedThreadPool(poolSize);

        for (int index = 0; index < numberOfTasks; index++) {
            executorService.submit(new KthTask(resultingMatrix, matrix1, matrix2, index, numberOfTasks));
        }

        executorService.shutdown();
        try {
            executorService.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
        } catch (InterruptedException exception) {
            System.out.println(exception.getMessage());
        }

        long endTime = System.currentTimeMillis();
        System.out.println("K-th tasks with ThreadPool took " + (endTime - startTime) + " milliseconds");

        return new Matrix(resultingMatrix);
    }
}