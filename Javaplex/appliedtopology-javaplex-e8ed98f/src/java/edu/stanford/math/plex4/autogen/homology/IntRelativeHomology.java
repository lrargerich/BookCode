package edu.stanford.math.plex4.autogen.homology;

import java.util.Comparator;

import edu.stanford.math.plex4.homology.barcodes.AnnotatedBarcodeCollection;
import edu.stanford.math.plex4.homology.barcodes.BarcodeCollection;
import edu.stanford.math.plex4.streams.interfaces.AbstractFilteredStream;
import edu.stanford.math.primitivelib.autogen.algebraic.IntAbstractField;
import edu.stanford.math.primitivelib.autogen.formal_sum.IntSparseFormalSum;
import edu.stanford.math.primitivelib.autogen.pair.ObjectObjectPair;
import gnu.trove.THashMap;





public class IntRelativeHomology<U> extends IntPersistentHomology<U> {
		/**
	 * This constructor initializes the object with a field and a comparator on the basis type.
	 * 
	 * @param field a field structure on the type int
	 * @param basisComparator a comparator on the basis type U
	 * @param minDimension the minimum dimension to compute 
	 * @param maxDimension the maximum dimension to compute
	 */
	public IntRelativeHomology(IntAbstractField field, Comparator<U> basisComparator, int minDimension, int maxDimension) {
		super(field, basisComparator, minDimension, maxDimension);
	}
	
	@Override
	protected AnnotatedBarcodeCollection<Integer, IntSparseFormalSum<U>> getAnnotatedIntervals(
			ObjectObjectPair<THashMap<U, IntSparseFormalSum<U>>, 
			THashMap<U, IntSparseFormalSum<U>>> RV_pair, 
			AbstractFilteredStream<U> stream) {
			
		return this.getAnnotatedIntervals(RV_pair, stream, false);
	}

	@Override
	protected BarcodeCollection<Integer> getIntervals(ObjectObjectPair<THashMap<U, IntSparseFormalSum<U>>, 
			THashMap<U, IntSparseFormalSum<U>>> RV_pair,
			AbstractFilteredStream<U> stream) {
			
		return this.getIntervals(RV_pair, stream, false);
	}
}
