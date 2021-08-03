/// Set of form-related typedefs.
library type;

import 'package:flutter/material.dart';

import 'core.dart';

/// Form fields that builds a [TextFormField].
typedef ToTextField = TextFormField Function(BuildContext);

/// Form fields that builds a [TextFormField].
typedef ToBasicTextField = BasicTextField Function(BuildContext);

/// Form related widget builder.
typedef ToFormWidget = Widget Function(BuildContext);
