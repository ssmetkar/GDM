public class OverlappingCommunities
{
	private int adj_matrix[][];
	private int vertices;
	private int edges;
	private Map<Integer,Integer> numberOfEdges;
	private Map<Integer,Float> density_metric;
	private Map<Integer,<Set<Integer>> clusters;

	public OverlappingCommunities(String filename)
	{
		generateGraph(filename);
		this.numberOfEdges = new HashMap<Integer,Integer>();
		this.density_metric = new HashMap<Integer,Float>();
		this.cluster = new HashMap<Integer,Set<Integer>>();
	}

	public void generateGraph(String filename)
	{
		File graphFile = new File(filename);
		BufferedReader fileReader = new BufferedReader(new FileReader(graphFile));
		String line = br.readLine();

		String tokens[] = line.split(" ");
		
		this.vertices = Integer.parseInt(tokens[0]);
		this.edges = Integer.parseInt(tokens[1]);
		
		int vert1, vert2;
		while((line = br.readLine()) != null)
		{
			tokens = line.split(" ");
			vert1 = Integer.parseInt(tokens[0]);
			vert2 = Integer.parseInt(tokens[1]);
			adj_matrix[vert1][vert2] = 1;
			adj_matrix[vert2][vert1] = 1;
		}
		graphFile.close();
	}

	/*
	* Implementation of Link Aggregate algorithm to calculate the initial set of clusters
	*/
	public void linkAggregate(List<Integer> nodeList)
	{
		int added;
		float newMetricValue;

		for(int vertex = nodeList.size() - 1; vertex >= 0 ; vertex--)
		{
			//create a new entry in cluster if there are no cluster in the list or there is no increase in density metric for that particular cluster
			added = 0;
			for(int cluster = 0; clusters.size(); cluster++)
			{
				newMetricValue = calculateAverageDegree(cluster, vertex);
				if(newMetricValue > 0)
				{
					added = 1;
				}
			}
			if(!added){
				this.numberOfEdges.put(clusters.size(), 0);
				this.density_metric.put(clusters.size(), 0);
				this.clusters.put(clusters.size(),(new HashSet()).add(vertex));
			}
		}
	}

	/**
	*  Calculates average degree density metric 
	*/
	private float calculateAverageDegree(int cluster, int vertex)
	{
		Set<Integer> clusterNodes = this.clusters.get(cluster);
		int edgeCount = this.numberOfEdges.get(cluster);
		int countOfEdges = 0;
		float currentMetricValue = this.density_metric.get(cluster);

		for(Integer node : clusterNodes)
		{
			if(adj_matrix[node][vertex] == 1)
				countOfEdges++;
		}

		if(countOfEdges > 0)
		{
			float newMetricValue = 2 * (edgeCount + countOfEdges) / clusterNodes.size();

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
	* Construcs a set of clusters with local maximum w.r.t. density function (in this case , average degree)
	* It needs the initial set of clusters generated through linkAggregate method and the density metric values for each of them
	* Actual algorithm takes as input (seed, Graph, density_metric_values)
	*/
	public void improvedIterativeScan()
	{
		// Seed -> a single cluster from set of clusters
		// Graph -> adj_matrix
		// density metric values -> density_metric
		// serialize the cluster into a file
		Set<Integer> neighbors;
		for(int cno; clusters.size(); cno++)
		{
			Set<Integer> cluster = this.clusters.get(cno);
			neighbors = new HashSet<Integer>();
			neighbors.addAll(cluster);
			boolean increased = true;
			float previousMetricValue = this.density_metric.get(cno);
			float metric_value;

			while(increased)
			{
				//calculate neighbors for each vertex in cluster
				for(int node : cluster)
				{
					//getadjacent nodes for that node
					for(int count = 0 count < this.vertices; count++)
					{
						if(adj_matrix[node][count] == 1)
							neighbors.add(count);
					}
				}

				//
				Set<Integer> newCluster = new HashSet<Integer>();

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
						cluster = newCluster;
						this.clusters.put(cno, cluster);
						previousMetricValue = metric_value;
					}

					newCluster.clear();
				}

				if(previousMetricValue == this.density_metric.get(cno))
					increased = 0;
				else
					this.density_metric.put(cno,previousMetricValue);
			}	
			
			File file = new File("cluster.out");
			BufferedWriter  writer = new BufferedWriter(new FileWriter(file));

			for(Set<Integer> cluster : clusters)
			{
				StringBuffer str = new StringBuffer();
				for(int cnt = 0; cnt < cluster.size(); cnt++)
				{
					str.append(cluster.get(cnt)).append(" ");
				}
				str.append("\n");
				writer.write(str,0,str.toString().length());	
			}

			writer.close();
			file.close();
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
		return (2 * countOfEdges / newCluster.size());
	}

	public static int main(String args[])
	{
		//args[0] - Graph file
		//args[1] - Output from map-reduce program to get ordering of nodes
		OverlappingCommunities communityDetector = new OverlappingCommunities(args[0]);


		//Order vertices using degree distribution
		File nodeOrderedFile = new File(args[1]);
		BufferedReader reader = new BufferedReader(new FileReader(nodeOrderedFile));
		String line;
		String tokens[];
		ArrayList<Integer> nodeList = new ArrayList<Integer>();

		while((line = reader.readLine()) != null )
		{
			tokens = line.split(" ");
			nodeList.add(Integer.parseInt(tokens[1]));
		}

		communityDetector.linkAggregate(nodeList);
		//communityDetector.improvedIterativeScan();
	}
}