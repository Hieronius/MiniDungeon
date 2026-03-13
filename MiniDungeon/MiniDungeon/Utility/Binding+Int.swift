import SwiftUI

public extension Binding {

	/// Method to convert Int data type values of @Binding property to Float to use in Slider
	static func convert<TInt, TFloat>(_ intBinding: Binding<TInt>) -> Binding<TFloat>
	where TInt:   BinaryInteger,
		  TFloat: BinaryFloatingPoint{

		Binding<TFloat> (
			get: { TFloat(intBinding.wrappedValue) },
			set: { intBinding.wrappedValue = TInt($0) }
		)
	}

	/// Method to convert Float data type values from @Binding property to Int
	static func convert<TFloat, TInt>(_ floatBinding: Binding<TFloat>) -> Binding<TInt>
	where TFloat: BinaryFloatingPoint,
		  TInt:   BinaryInteger {

		Binding<TInt> (
			get: { TInt(floatBinding.wrappedValue) },
			set: { floatBinding.wrappedValue = TFloat($0) }
		)
	}
}

