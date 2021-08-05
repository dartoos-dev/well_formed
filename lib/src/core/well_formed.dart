import 'package:flutter/material.dart';

/// Something that retrieves a form container.
typedef ToForm = Widget Function(BuildContext);

/// Something that retrieves the submission widget.
typedef ToSubmit = Widget Function(VoidCallback);

/// Something that retrieves the reset widget.
typedef ToReset = Widget Function(VoidCallback);

/// A convenient well-formed form widget!
///
/// It builds a [Form] within a structure consisting of a [SafeArea] and
/// [Column] for the [Form] instance and related fields, and a [ListTile] for
/// the action widgets (submission, reset, etc.).
class WellFormed extends StatelessWidget {
  /// A [Form] that is suitable for the most common scenarios.
  ///
  /// [fields] the [Form]'s fields.
  /// [submit] a factory function for building the submission widget.
  /// [reset] an optional factory function for building the reset widget.
  /// [leading] an optional extra widget that will be placed on the leftmost
  /// position alongside the [submit] and [reset] widgets.
  /// [formKey] the form state key; if omitted, a new one will be generated.
  WellFormed(
    List<Widget> fields, {
    required ToSubmit submit,
    ToReset? reset,
    Widget? leading,
    GlobalKey<FormState>? formKey,
    Key? key,
  })  : _toForm = ((context) {
          final fkey = formKey ?? GlobalKey<FormState>();
          return SafeArea(
            child: Column(children: [
              Form(
                key: fkey,
                child: Column(children: fields),
              ),
              ListTile(
                leading: leading ?? const SizedBox(),
                title: submit(() {
                  final formState = fkey.currentState;
                  if (formState != null) {
                    if (formState.validate()) {
                      formState.save();
                    }
                  }
                }),
                trailing: reset == null
                    ? const SizedBox()
                    : reset(() {
                        final formState = fkey.currentState;
                        if (formState != null) {
                          formState.reset();
                        }
                      }),
              ),
            ]),
          );
        }),
        super(key: key);

  /// Convenient Scrollable Form Widget.
  ///
  /// [fields] the [Form]'s fields.
  /// [submit] factory function for the submission widget.
  /// [reset] optional factory function for the reset widget.
  /// [leading] optional extra widget that will be placed in the leftmost
  /// position alongside [submit] and [reset] widgets.
  /// [scrollDirection] the axis along which the scroll view scrolls.
  /// [formKey] the form state key; if omitted, one will be generated.
  WellFormed.scroll(
    List<Widget> fields, {
    required ToSubmit submit,
    ToReset? reset,
    Widget? leading,
    Axis scrollDirection = Axis.vertical,
    GlobalKey<FormState>? formKey,
    Key? key,
  })  : _toForm = ((context) {
          return SingleChildScrollView(
            scrollDirection: scrollDirection,
            child: WellFormed(
              fields,
              submit: submit,
              reset: reset,
              leading: leading,
              formKey: formKey,
            ),
          );
        }),
        super(key: key);

  /// Convenient Scrollable Form Widget that contains a [ElevatedButton] for
  /// submission along with an optional reset [TextButton]for resetting all form
  /// fields back to their [FormField.initialValue].
  ///
  /// [fields] the [Form]'s fields.
  /// [enabled] enable/disable flag.
  /// [hasReset] if true, the form will have a reset button.
  /// [submitChild] the child widget of the submission button.
  /// [resetChild] the child widget of the reset button.
  /// [leading] if set, an extra widget will be placed on the leftmost position
  /// alongside the submission and reset buttons.
  /// [scrollDirection] the axis along which the scroll view scrolls.
  /// [formKey] the form state key; if omitted, one will be generated.
  /// [submitKey] the submit button key — it might be useful for unit testing.
  /// [resetKey] the reset button key — it might be useful for unit testing.
  WellFormed.btn(
    List<Widget> fields, {
    bool enabled = true,
    bool hasReset = true,
    Widget submitChild = const Text('Submit'),
    Widget resetChild = const Text('Reset'),
    Widget? leading,
    ButtonStyle? submitStyle,
    ButtonStyle? resetStyle,
    VoidCallback? onSub,
    VoidCallback? onReset,
    Axis scrollDirection = Axis.vertical,
    GlobalKey<FormState>? formKey,
    Key? submitKey,
    Key? resetKey,
    Key? key,
  }) : this.scroll(
          fields,
          scrollDirection: scrollDirection,
          submit: (VoidCallback submit) {
            return ElevatedButton(
              key: submitKey,
              style: submitStyle,
              onPressed: !enabled
                  ? null
                  : () {
                      submit();
                      onSub?.call();
                    },
              child: submitChild,
            );
          },
          reset: (VoidCallback reset) {
            return !hasReset
                ? const SizedBox()
                : TextButton(
                    key: resetKey,
                    style: resetStyle,
                    onPressed: !enabled
                        ? null
                        : () {
                            reset();
                            onReset?.call();
                          },
                    child: resetChild,
                  );
          },
          leading: leading,
          formKey: formKey,
          key: key,
        );

  /// A [Form] within a [MaterialApp] container.
  ///
  /// This configuration is suitable for unit testing or when the whole
  /// application boils down to the form itself.
  ///
  /// [fields] the [Form]'s fields.
  /// [enabled] enable/disable flag.
  /// [hasReset] if true, the form will have a reset button.
  /// [title] the [MaterialApp.title] value.
  /// [submitChild] the child widget of the submission button.
  /// [resetChild] the child widget of the reset button.
  /// [leading] if set, an extra widget will be placed on the leftmost position
  /// alongside the submission and reset buttons.
  /// [scrollDirection] the axis along which the scroll view scrolls.
  /// [formKey] the form state key; if omitted, a new key will be generated.
  /// [submitKey] the submit button key — it might be useful for unit testing.
  /// [resetKey] the reset button key — it might be useful for unit testing.
  WellFormed.app(
    List<Widget> fields, {
    bool enabled = true,
    bool hasReset = true,
    String title = '',
    Widget submitChild = const Text('Submit'),
    Widget resetChild = const Text('Reset'),
    Widget? leading,
    VoidCallback? onSub,
    VoidCallback? onReset,
    ButtonStyle? submitStyle,
    ButtonStyle? resetStyle,
    Axis scrollDirection = Axis.vertical,
    GlobalKey<FormState>? formKey,
    Key? submitKey,
    Key? resetKey,
    Key? key,
  })  : _toForm = ((context) {
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: WellFormed.btn(
                fields,
                enabled: enabled,
                hasReset: hasReset,
                formKey: formKey,
                submitChild: submitChild,
                resetChild: resetChild,
                leading: leading,
                submitStyle: submitStyle,
                resetStyle: resetStyle,
                scrollDirection: scrollDirection,
                onSub: onSub,
                onReset: onReset,
                resetKey: resetKey,
                submitKey: submitKey,
              ),
            ),
          );
        }),
        super(key: key);

  /// Form builder.
  final ToForm _toForm;

  @override
  Widget build(BuildContext context) => _toForm(context);
}
