/// Set of form-related typedefs.
library type;

import 'package:flutter/material.dart';

/// Form fields that builds a [TextFormField].
typedef ToTextField = TextFormField Function(BuildContext);

/// Form related widget builder.
typedef ToFormWidget = Widget Function(BuildContext);
