import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.RecursiveTask;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class HamiltonianCycleSearchTask extends RecursiveTask<Boolean> {
    private final List<List<Integer>> graph;
    private final int currentNode;
    private final int startingNode;
    private final AtomicBoolean foundHamiltonianCycle;
    private final List<Integer> currentPath;
    private final List<Integer> output;
    private final Lock lock;
    private final List<Boolean> visited;

    public HamiltonianCycleSearchTask(
            List<List<Integer>> graph,
            int currentNode,
            int startingNode,
            AtomicBoolean foundHamiltonianCycle,
            List<Integer> currentPath,
            List<Boolean> visited,
            List<Integer> output) {
        this.graph = graph;
        this.currentNode = currentNode;
        this.startingNode = startingNode;
        this.foundHamiltonianCycle = foundHamiltonianCycle;
        this.currentPath = new ArrayList<>(currentPath);
        this.visited = new ArrayList<>(visited);
        this.output = output;
        this.lock = new ReentrantLock();
    }

    private void foundCycle() {
        currentPath.add(startingNode);
        foundHamiltonianCycle.set(true);
        lock.lock();
        try {
            output.clear();
            output.addAll(currentPath);
        } finally {
            lock.unlock();
        }
    }

    @Override
    protected Boolean compute() {
        if (foundHamiltonianCycle.get()) {
            return true;
        }

        currentPath.add(currentNode);
        visited.set(currentNode, true);

        if (currentPath.size() == graph.size() && graph.get(currentNode).contains(startingNode)) {
            foundCycle();
            return true;
        }

        List<HamiltonianCycleSearchTask> tasks = new ArrayList<>();
        for (Integer neighbor : graph.get(currentNode)) {
            if (!visited.get(neighbor)) {
                HamiltonianCycleSearchTask task = new HamiltonianCycleSearchTask(
                        graph, neighbor, startingNode, foundHamiltonianCycle, currentPath, visited, output);
                tasks.add(task);
            }
        }

        invokeAll(tasks);

        for (HamiltonianCycleSearchTask task : tasks) {
            if (task.join()) {
                return true;
            }
        }

        return false;
    }
}
