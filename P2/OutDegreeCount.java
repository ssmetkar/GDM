package gdm.degreecount;

import java.io.IOException;
import java.util.*;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

/*
* Steps to create the jar
* mkdir outdegree
* javac -classpath ${HADOOP_HOME}/hadoop-{version}-core.jar -d outdegree OutDegreeCount.java
* jar -cvf outdegree.jar - C outdegree/ .
*
*/
public class OutDegreeCount
{
	public static class Map extends Mapper<LongWritable, Text, IntWritable, IntWritable> {

		private final static IntWritable one = new IntWritable(1);
		private IntWritable vertex = new IntWritable();
		private static boolean isFirst = true;

		public void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException{
			String line = value.toString();

			if(!isFirst)
			{
				int temp;
				StringTokenizer tokenizer = new StringTokenizer(line);
				while(tokenizer.hasMoreTokens())
				{
					temp = Integer.parseInt(tokenizer.nextToken());
					vertex.set(temp);
					context.write(vertex,one);

					temp = Integer.parseInt(tokenizer.nextToken());
					vertex.set(temp);
					context.write(vertex,one);
				}

			} else {
				isFirst = false;
			}
		}
	}

	public static class Reduce extends Reducer<IntWritable, IntWritable, IntWritable , IntWritable> {

		public void reduce(IntWritable key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException{
			int sum = 0;
			for(IntWritable val : values)
			{
				sum += val.get();
			}
			context.write(new IntWritable(sum),key);
		}
	}

	public static class SortMap extends Mapper<LongWritable, Text, IntWritable, IntWritable> {
		private IntWritable vertex = new IntWritable();
		private IntWritable node = new IntWritable();

		public void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException {

			String line = value.toString();
			StringTokenizer tokenizer = new StringTokenizer(line);

			int degree = Integer.parseInt(tokenizer.nextToken());
			vertex.set(degree);
			int node1 = Integer.parseInt(tokenizer.nextToken());
			node.set(node1);
			context.write(vertex,node);
		}
	}

	public static class SortReduce extends Reducer<IntWritable, IntWritable, IntWritable, IntWritable> {
		public void reduce(IntWritable key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
			for(IntWritable val: values)
			{
				context.write(key,val);
			}		
		}
	}
	

	public static void main(String args[]) throws Exception
	{
		Configuration conf = new Configuration();
		Job job = new Job(conf,"degreecount");

		job.setOutputKeyClass(IntWritable.class);
		job.setOutputValueClass(IntWritable.class);
	
		job.setMapperClass(Map.class);
		job.setReducerClass(Reduce.class);

		job.setInputFormatClass(TextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);

		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		job.setJarByClass(OutDegreeCount.class);
		job.waitForCompletion(true);

		Configuration other_conf = new Configuration();
		Job job2 = new Job(other_conf,"sorting");
		job2.setOutputKeyClass(IntWritable.class);
		job2.setOutputValueClass(IntWritable.class);

		job2.setMapperClass(SortMap.class);
		job2.setReducerClass(SortReduce.class);

		job2.setInputFormatClass(TextInputFormat.class);
		job2.setOutputFormatClass(TextOutputFormat.class);

		FileInputFormat.addInputPath(job2, new Path(args[1]));
		FileOutputFormat.setOutputPath(job2,new Path(args[2]));

		job2.setJarByClass(OutDegreeCount.class);
		job2.waitForCompletion(true);
	}
}
