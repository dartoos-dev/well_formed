/// Form fields related to numeric values.
///
/// Examples of numeric input data:
///
/// - a three-digit numeric code.
/// - a six-digit password.
/// - a hexadecimal input.
/// - Minimum Order Quantity — the fewest number of units required at one time.
///
/// Consider using:
///
/// - [DigitField] for digit [0–9] entry. This is ideal for verification codes,
///   PIN codes, etc.
/// - [HexField] for hexadecimal digit [0–9A–F] entry. It is ideal for
///   registring device numbers.
/// - [IntField] for integer values. It is ideal for entering the quantity of an
///   item, number of children, age, etc.
/// - [NumField] for floating point values. It is ideal for displaying the total
///   price of a shopping cart, getting an auction bid, etc.
library numeric;

export 'src/numeric/digit_field.dart';
export 'src/numeric/hex_field.dart';
export 'src/numeric/int_field.dart';
export 'src/numeric/num_field.dart';
