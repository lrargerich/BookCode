package edu.stanford.math.plex4.homology;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.math.plex4.homology.barcodes.AnnotatedBarcodeCollection;
import edu.stanford.math.plex4.homology.barcodes.BarcodeCollection;
import edu.stanford.math.plex4.homology.interfaces.AbstractPersistenceAlgorithm;
import edu.stanford.math.plex4.homology.interfaces.AbstractPersistenceBasisAlgorithm;
import edu.stanford.math.plex4.streams.interfaces.AbstractFilteredStream;
import edu.stanford.math.plex4.test_utility.Timing;

/**
 * This class contains functions that verify the equality of different persistence algorithms.
 * 
 * @author Andrew Tausz
 *
 */
public class PersistenceAlgorithmTester {

	/**
	 * This function verifies that all of the persistence algorithms in the supplied collection produce equal values when
	 * applied to the given stream.
	 * 
	 * @param <T> the basis element type
	 * @param algorithms the set of algorithms to compare
	 * @param stream the stream to compare on
	 */
	public static <T> void verifyEquality(List<AbstractPersistenceAlgorithm<T>> algorithms, AbstractFilteredStream<T> stream) {
		System.out.println("Stream size: " + stream.getSize());
		List<BarcodeCollection<Integer>> barcodes = new ArrayList<BarcodeCollection<Integer>>();
		for (AbstractPersistenceAlgorithm<T> algorithm: algorithms) {
			Timing.restart();
			barcodes.add(algorithm.computeIndexIntervals(stream));
			//System.out.println(barcodes.get(barcodes.size() - 1));
			Timing.stopAndDisplay(algorithm.toString());
		}
		
		int n = barcodes.size();
		for (int i = 0; i < n; i++) {
			for (int j = i + 1; j < n; j++) {
				if (!barcodes.get(i).equals(barcodes.get(j))) {
					System.out.println(algorithms.get(i) + " != " + algorithms.get(j));
					System.out.println(algorithms.get(i));
					System.out.println(barcodes.get(i));
					System.out.println(algorithms.get(j));
					System.out.println(barcodes.get(j));
				}
				assertTrue("Computed barcodes are not equal for algorithms " + algorithms.get(i) + " and " + algorithms.get(j), barcodes.get(i).equals(barcodes.get(j)));
			}
		}	
	}
	
	/**
	 * This function verifies that all of the persistence basis algorithms in the collection produce equal results.
	 * 
	 * @param <T> the basis element type
	 * @param <B> the type of the interval generators
	 * @param algorithms the set of algorithms to compare
	 * @param stream the stream to compare on
	 */
	public static <T, B> void verifyEqualityWithGenerators(List<AbstractPersistenceBasisAlgorithm<T, B>> algorithms, AbstractFilteredStream<T> stream) {
		System.out.println("Stream size: " + stream.getSize());
		List<AnnotatedBarcodeCollection<Integer, B>> barcodes = new ArrayList<AnnotatedBarcodeCollection<Integer, B>>();
		for (AbstractPersistenceBasisAlgorithm<T, B> algorithm: algorithms) {
			Timing.restart();
			barcodes.add(algorithm.computeAnnotatedIndexIntervals(stream));
			Timing.stopAndDisplay(algorithm.toString());
		}
		
		int n = barcodes.size();
		for (int i = 0; i < n; i++) {
			for (int j = i + 1; j < n; j++) {
				if (!barcodes.get(i).equals(barcodes.get(j))) {
					System.out.println(algorithms.get(i) + " != " + algorithms.get(j));
					System.out.println(algorithms.get(i));
					System.out.println(barcodes.get(i));
					System.out.println(algorithms.get(j));
					System.out.println(barcodes.get(j));
				}
				assertTrue("Computed barcodes are not equal for algorithms " + algorithms.get(i) + " and " + algorithms.get(j), barcodes.get(i).equals(barcodes.get(j)));
			}
		}	
	}
	
	/**
	 * This function verifies that all of the given persistence algorithms in the supplied collection produce
	 * equal values when applied to each element in the given set of streams.
	 * 
	 * @param <T> the basis element type
	 * @param algorithms the set of algorithms to compare
	 * @param streams the set of streams to use as comparisons
	 */
	public static <T> void verifyEquality(List<AbstractPersistenceAlgorithm<T>> algorithms, Iterable<AbstractFilteredStream<T>> streams) {
		for (AbstractFilteredStream<T> stream: streams) {
			verifyEquality(algorithms, stream);
		}
	}
	
	/**
	 * This function verifies that all of the given persistence algorithms in the supplied collection produce
	 * equal values when applied to each element in the given set of streams.
	 * 
	 * @param <T> the basis element type
	 * @param <B> the type of the interval generators
	 * @param algorithms the set of algorithms to compare
	 * @param streams the set of streams to use as comparisons
	 */
	public static <T, B> void verifyEqualityWithGenerators(List<AbstractPersistenceBasisAlgorithm<T, B>> algorithms, Iterable<AbstractFilteredStream<T>> streams) {
		for (AbstractFilteredStream<T> stream: streams) {
			verifyEqualityWithGenerators(algorithms, stream);
		}
	}
}
