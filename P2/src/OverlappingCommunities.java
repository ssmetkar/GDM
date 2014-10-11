import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;

public class OverlappingCommunities
{
	private int adj_matrix[][];
	private int vertices;
	private int edges;
	private Map<Integer,Integer> numberOfEdges;
	private Map<Integer,Float> density_metric;
	private Map<Integer,Set<Integer>> clusters;

	public OverlappingCommunities()
	{
		this.numberOfEdges = new HashMap<Integer,Integer>();
		this.density_metric = new HashMap<Integer,Float>();
		this.clusters = new HashMap<Integer,Set<Integer>>();
	}

	public void generateGraph(String filename) throws Exception
	{
		File graphFile = new File(filename);
		BufferedReader br = new BufferedReader(new FileReader(graphFile));
		String line = br.readLine();

		String tokens[] = line.split(" ");
		
		this.vertices = Integer.parseInt(tokens[0]);
		this.edges = Integer.parseInt(tokens[1]);
		adj_matrix = new int[vertices][vertices];

		int vert1, vert2;
		while((line = br.readLine()) != null)
		{
			tokens = line.split(" ");
			vert1 = Integer.parseInt(tokens[0]);
			vert2 = Integer.parseInt(tokens[1]);
			adj_matrix[vert1][vert2] = 1;
			adj_matrix[vert2][vert1] = 1;
		}
		br.close();
		//displayMatrix();
	}

	private void displayMatrix()
	{
		for(int cnt = 0 ; cnt < vertices ; cnt++)
		{
			for(int cnt2 = 0; cnt2 < vertices ; cnt2++)
			{
				System.out.print(adj_matrix[cnt][cnt2] + "\t");
			}
			System.out.println("");
		}		
	}

	/*
	* Implementation of Link Aggregate algorithm to calculate the initial set of clusters
	*/
	public void linkAggregate(List<Integer> nodeList) throws Exception
	{
		int added, node;
		float newMetricValue;
		Set<Integer> newSet;

		for(int vertex = nodeList.size() - 1; vertex >= 0 ; vertex--)
		{
			//create a new entry in cluster if there are no cluster in the list 
			//or there is no increase in density metric for that particular cluster
			node = nodeList.get(vertex);
			added = 0;
			for(int cluster = 0; cluster < clusters.size(); cluster++)
			{
				newMetricValue = calculateAverageDegree(cluster, node);
				if(newMetricValue > 0)
				{
					added = 1;
				}
			}
			//If this vertex was not added to any of the cluster add a new cluster containing that vertex
			if(added == 0){
				this.numberOfEdges.put(clusters.size(), 0);
				this.density_metric.put(clusters.size(), 0F);
				newSet = new HashSet<Integer>();
				newSet.add(node);
				this.clusters.put(clusters.size(),newSet);
			}
		}
	}

	/**
	*  Calculates average degree density metric 
	*  Parameters : cluster -> cluster number
	*				vertex -> vertex number	
	*  Returns : new density metric value or -1 
	*/
	private float calculateAverageDegree(int cluster, int vertex)
	{
		Set<Integer> clusterNodes = this.clusters.get(cluster);
		//Previously computed number of edges
		int edgeCount = this.numberOfEdges.get(cluster);
		//New edges added in the list
		int countOfEdges = 0;
		float currentMetricValue = this.density_metric.get(cluster);

		//for all the vertices in the cluster check if there is an edge between that vertex and the new vertex that can
		//be added
		for(Integer node : clusterNodes)
		{
			if(adj_matrix[node][vertex] == 1)
				countOfEdges++;
		}

		//if new edges are added then compute the density metric value for that cluster
		//if greater than the previous value than update the density metric value in the density_metric map
		//Update the number of edges fot that cluster
		//Add the new vertex in the cluster
		if(countOfEdges > 0)
		{
			float newMetricValue = (float) 2 * (edgeCount + countOfEdges) / (clusterNodes.size() + 1);

			if(newMetricValue > currentMetricValue)
			{
				clusterNodes.add(vertex);
				this.clusters.put(cluster, clusterNodes);
				this.density_metric.put(cluster,newMetricValue);
				this.numberOfEdges.put(cluster,edgeCount + countOfEdges);
				return newMetricValue;
			}	
		}
		return -1;			
	}

	/*
	* Constructs a set of clusters with local maximum w.r.t. density function (in this case , average degree)
	* It needs the initial set of clusters generated through linkAggregate method and the density metric values for each of them
	* Actual algorithm takes as input (seed, Graph, density_metric_values)
	*/
	public void improvedIterativeScan()
	{
		// Seed -> a single cluster from set of clusters
		// Graph -> adj_matrix
		// density metric values -> density_metric
		// serialize the cluster into a file
		Set<Integer> neighbors, cluster, newCluster;
		boolean increased;
		float previousMetricValue, metric_value;

		for(int cno = 0; cno < clusters.size(); cno++)
		{
			cluster = this.clusters.get(cno);
			neighbors = new HashSet<Integer>();
			
			increased = true;

			while(increased)
			{
				previousMetricValue = this.density_metric.get(cno);
				neighbors.addAll(cluster);
				//Add neighbors for each vertex in the cluster
				for(int node : cluster)
				{
					//getadjacent nodes for that node
					for(int count = 0; count < this.vertices; count++)
					{
						if(adj_matrix[node][count] == 1)
							neighbors.add(count);
					}
				}

				newCluster = new HashSet<Integer>();

				for(int node : neighbors)
				{
					newCluster.addAll(cluster);	

					if (cluster.contains(node))
					{
						newCluster.remove(node);
					} else {
						newCluster.add(node);
					}

					metric_value = computeDensityMetric(newCluster);

					if(metric_value > previousMetricValue)
					{
						cluster.clear();
						cluster.addAll(newCluster);
						this.clusters.put(cno, cluster);
						previousMetricValue = metric_value;
					}

					newCluster.clear();
				}

				if(previousMetricValue == this.density_metric.get(cno))
					increased = false;
				else
					this.density_metric.put(cno,previousMetricValue);
			}	
			
			// File file = new File("cluster.out");
			// BufferedWriter  writer = new BufferedWriter(new FileWriter(file));

			// for(Set<Integer> cluster : clusters)
			// {
			// 	StringBuffer str = new StringBuffer();
			// 	for(int cnt = 0; cnt < cluster.size(); cnt++)
			// 	{
			// 		str.append(cluster.get(cnt)).append(" ");
			// 	}
			// 	str.append("\n");
			// 	writer.write(str,0,str.toString().length());	
			// }

			// writer.close();
			// file.close();
		}

		for (int cnt = 0; cnt < clusters.size(); cnt++) {
			for(int node : clusters.get(cnt))
            {
                System.out.print(node+" ");
            }
            System.out.print("\n");
		}
	}

	private float computeDensityMetric(Set<Integer> newCluster)
	{
		int countOfEdges = 0;
		for(int cnt1 = 0; cnt1 < newCluster.size(); cnt1++)
		{
			for(int cnt2 = 0; cnt2 < newCluster.size(); cnt2++ )
			{
				if(adj_matrix[cnt1][cnt2] == 1)
					countOfEdges++;
			}
		}
		return ((float) countOfEdges / newCluster.size());
	}

	public static void main(String args[]) throws Exception
	{
		//args[0] - Graph file
		//args[1] - Output from map-reduce program to get ordering of nodes
		OverlappingCommunities communityDetector = new OverlappingCommunities();
		communityDetector.generateGraph(args[0]);

		//Order vertices using degree distribution
		File nodeOrderedFile = new File(args[1]);
		BufferedReader reader = new BufferedReader(new FileReader(nodeOrderedFile));
		String line;
		String tokens[];
		ArrayList<Integer> nodeList = new ArrayList<Integer>();

		while((line = reader.readLine()) != null )
		{
			tokens = line.split("	");
			nodeList.add(Integer.parseInt(tokens[1]));
		}
		communityDetector.linkAggregate(nodeList);
		communityDetector.improvedIterativeScan();
		reader.close();
	}
}
