import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.atomic.AtomicBoolean;

public class Main {
    private static List<List<Integer>> generateRandomGraph(int nrVertices, int nrEdges) throws Exception {
        if (nrVertices * (nrVertices - 1) < nrEdges) {
            throw new Exception("Invalid number of edges for the graph!");
        }

        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < nrVertices; i++) {
            graph.add(new ArrayList<>());
        }

        Random random = new Random();
        int index = 1;
        while (index <= nrEdges) {
            int nodeA = random.nextInt(nrVertices);
            int nodeB = random.nextInt(nrVertices);

            if (nodeA != nodeB && !graph.get(nodeA).contains(nodeB)) {
                graph.get(nodeA).add(nodeB);
                index++;
            }
        }

        System.out.println("Generated Graph:");
        System.out.println("Number of Nodes: " + nrVertices);
        System.out.println("Number of Edges: " + nrEdges);
        for (int i = 0; i < graph.size(); i++) {
            System.out.println("Node " + i + " -> " + graph.get(i));
        }

        return graph;
    }

    private static List<List<Integer>> loadGraph(String path) throws FileNotFoundException {
        List<List<Integer>> graph = new ArrayList<>();

        try (Scanner scanner = new Scanner(new File(path))) {
            int size = Integer.parseInt(scanner.nextLine());
            for (int i = 0; i < size; i++) {
                graph.add(new ArrayList<>());
            }
            while (scanner.hasNextLine()) {
                String[] splitEdge = scanner.nextLine().split(" ");
                graph.get(Integer.parseInt(splitEdge[0])).add(Integer.parseInt(splitEdge[1]));
            }
        }

        return graph;
    }

    public static void main(String[] args) throws Exception {
        int nrVertices = 5;
        int nrEdges = 8;
        //List<List<Integer>> graph = loadGraph("graphs/graph1.txt");
        List<List<Integer>> graph = loadGraph("graphs/graph2.txt");
        //List<List<Integer>> graph = generateRandomGraph(nrVertices, nrEdges);

        AtomicBoolean foundHamiltonianCycle = new AtomicBoolean(false);
        List<Integer> output = new ArrayList<>();
        List<Boolean> visited = new ArrayList<>();
        for (int i = 0; i < graph.size(); i++) {
            visited.add(false);
        }

        long startTime = System.nanoTime();

        ForkJoinPool pool = ForkJoinPool.commonPool();
        HamiltonianCycleSearchTask task = new HamiltonianCycleSearchTask(
                graph, 0, 0, foundHamiltonianCycle, new ArrayList<>(), visited, output);
        pool.invoke(task);

        long endTime = System.nanoTime();

        if (foundHamiltonianCycle.get()) {
            System.out.println("Hamiltonian Cycle Found: " + output);
        } else {
            System.out.println("No Hamiltonian Cycles");
        }

        // Print duration
        long durationInMillis = (endTime - startTime) / 1_000_000;
        System.out.println("Execution Time: " + durationInMillis + " ms");
    }
}
