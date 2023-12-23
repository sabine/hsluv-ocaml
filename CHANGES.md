# 0.1.0

First release.

Provides:
- record types for the different color spaces (HSLuv, HPLuv, RGB, XYZ, LCH, LUV)
- HSLuv and HPLuv color conversion functions
- color conversion functions between some of the other color spaces used to enable the HSLuv and HPluv conversions
- pretty printers for all provided color types
- a library `hsluv.float_conv` for conversions between float triples and the provided color types
- tests against the HSLuv reference (revision 4)