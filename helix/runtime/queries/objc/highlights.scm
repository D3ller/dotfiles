
(identifier) @variable

((identifier) @constant
  (#match? @constant "^[A-Z][A-Z\\d_]*$"))

"sizeof" @keyword

[
  "enum"
  "struct"
  "typedef"
  "union"
] @keyword.storage.type

[
  (type_qualifier)
  (storage_class_specifier)
] @keyword.storage.modifier

[
  "goto"
  "break"
  "continue"
] @keyword.control

[
  "do"
  "for"
  "while"
] @keyword.control.repeat

[
  "if"
  "else"
  "switch"
  "case"
  "default"
] @keyword.control.conditional

"return" @keyword.control.return

[
  "defined"
  "#define"
  "#elif"
  "#else"
  "#endif"
  "#if"
  "#ifdef"
  "#ifndef"
  "#include"
  (preproc_directive)
] @keyword.directive

"..." @punctuation

["," "." ":" "::" ";" "->"] @punctuation.delimiter

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

[
  "+"
  "-"
  "*"
  "/"
  "++"
  "--"
  "%"
  "=="
  "!="
  ">"
  "<"
  ">="
  "<="
  "&&"
  "||"
  "!"
  "&"
  "|"
  "^"
  "~"
  "<<"
  ">>"
  "="
  "+="
  "-="
  "*="
  "/="
  "%="
  "<<="
  ">>="
  "&="
  "^="
  "|="
  "?"
] @operator

(conditional_expression ":" @operator) ; After punctuation

(pointer_declarator "*" @type.builtin) ; After Operators
(abstract_pointer_declarator "*" @type.builtin)


[(true) (false)] @constant.builtin.boolean

(enumerator name: (identifier) @type.enum.variant)

(string_literal) @string
(system_lib_string) @string

(null) @constant
(number_literal) @constant.numeric
(char_literal) @constant.character
(escape_sequence) @constant.character.escape

(field_identifier) @variable.other.member
(statement_identifier) @label
(type_identifier) @type
(primitive_type) @type.builtin
(sized_type_specifier) @type.builtin

(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function))
(call_expression (argument_list (identifier) @variable))
(function_declarator
  declarator: [(identifier) (field_identifier)] @function)

; Up to 6 layers of declarators
(parameter_declaration
  declarator: (identifier) @variable.parameter)
(parameter_declaration
  (_
    (identifier) @variable.parameter))
(parameter_declaration
  (_
    (_
      (identifier) @variable.parameter)))
(parameter_declaration
  (_
    (_
      (_
        (identifier) @variable.parameter))))
(parameter_declaration
  (_
    (_
      (_
        (_
          (identifier) @variable.parameter)))))
(parameter_declaration
  (_
    (_
      (_
        (_
          (_
            (identifier) @variable.parameter))))))

(preproc_function_def
  name: (identifier) @function.special)

(attribute
  name: (identifier) @attribute)

(comment) @comment

; Preprocs

(preproc_undef
  name: (_) @constant) @keyword.directive

; Includes

(module_import "@import" @keyword.control.import path: (identifier) @namespace)

((preproc_include
  _ @keyword.control.import path: (_))
  (#any-of? @keyword.control.import "#include" "#import"))

; Type Qualifiers

[
  "@optional"
  "@required"
  "__covariant"
  "__contravariant"
  (visibility_specification)
] @keyword.storage.modifier

; Storageclasses

[
  "@autoreleasepool"
  "@synthesize"
  "@dynamic"
  "volatile"
  (protocol_qualifier)
] @keyword.storage.modifier

; Keywords

[
  "@protocol"
  "@interface"
  "@implementation"
  "@compatibility_alias"
  "@property"
  "@selector"
  "@defs"
  "availability"
  "@end"
] @keyword

(class_declaration "@" @keyword "class" @keyword) ; I hate Obj-C for allowing "@ class" :)

(method_definition ["+" "-"] @keyword.function)
(method_declaration ["+" "-"] @keyword.function)

[
  "__typeof__"
  "__typeof"
  "typeof"
  "in"
] @keyword.operator

[
  "@synchronized"
  "oneway"
] @keyword

; Exceptions

[
  "@try"
  "__try"
  "@catch"
  "__catch"
  "@finally"
  "__finally"
  "@throw"
] @keyword.control.exception

; Variables

((identifier) @variable.builtin
  (#any-of? @variable.builtin "self" "super"))

; Functions & Methods

[
  "objc_bridge_related"
  "@available"
  "__builtin_available"
  "va_arg"
  "asm"
] @function.builtin

(method_definition (identifier) @function.method)

(method_declaration (identifier) @function.method)

(method_identifier (identifier)? @function.method ":" @function.method (identifier)? @function.method)

(message_expression method: (identifier) @function.method)

; Constructors

((message_expression method: (identifier) @constructor)
  (#eq? @constructor "init"))

; Attributes

(availability_attribute_specifier 
  [
    "CF_FORMAT_FUNCTION" "NS_AVAILABLE" "__IOS_AVAILABLE" "NS_AVAILABLE_IOS"
    "API_AVAILABLE" "API_UNAVAILABLE" "API_DEPRECATED" "NS_ENUM_AVAILABLE_IOS"
    "NS_DEPRECATED_IOS" "NS_ENUM_DEPRECATED_IOS" "NS_FORMAT_FUNCTION" "DEPRECATED_MSG_ATTRIBUTE"
    "__deprecated_msg" "__deprecated_enum_msg" "NS_SWIFT_NAME" "NS_SWIFT_UNAVAILABLE"
    "NS_EXTENSION_UNAVAILABLE_IOS" "NS_CLASS_AVAILABLE_IOS" "NS_CLASS_DEPRECATED_IOS" "__OSX_AVAILABLE_STARTING"
    "NS_ROOT_CLASS" "NS_UNAVAILABLE" "NS_REQUIRES_NIL_TERMINATION" "CF_RETURNS_RETAINED"
    "CF_RETURNS_NOT_RETAINED" "DEPRECATED_ATTRIBUTE" "UI_APPEARANCE_SELECTOR" "UNAVAILABLE_ATTRIBUTE"
  ]) @attribute

; Macros

(type_qualifier
  [
    "_Complex"
    "_Nonnull"
    "_Nullable"
    "_Nullable_result"
    "_Null_unspecified"
    "__autoreleasing"
    "__block"
    "__bridge"
    "__bridge_retained"
    "__bridge_transfer"
    "__complex"
    "__kindof"
    "__nonnull"
    "__nullable"
    "__ptrauth_objc_class_ro"
    "__ptrauth_objc_isa_pointer"
    "__ptrauth_objc_super_pointer"
    "__strong"
    "__thread"
    "__unsafe_unretained"
    "__unused"
    "__weak"
  ]) @function.builtin

[ "__real" "__imag" ] @function.builtin

((call_expression function: (identifier) @function.macro)
  (#eq? @function.macro "testassert"))

; Types

(class_declaration (identifier) @type)

(class_interface "@interface" . (identifier) @type superclass: _? @type category: _? @namespace)

(class_implementation "@implementation" . (identifier) @type superclass: _? @type category: _? @namespace)

(protocol_forward_declaration (identifier) @type) ; @interface :(

(protocol_reference_list (identifier) @type) ; ^

[
  "BOOL"
  "IMP"
  "SEL"
  "Class"
  "id"
] @type.builtin

; Constants

(property_attribute (identifier) @constant "="?)

[ "__asm" "__asm__" ] @constant

; Properties

(property_implementation "@synthesize" (identifier) @variable.other.member)


; Parameters

(method_parameter ":" @function.method (identifier) @variable.parameter)

(method_parameter declarator: (identifier) @variable.parameter)

(parameter_declaration 
  declarator: (function_declarator 
                declarator: (parenthesized_declarator 
                              (block_pointer_declarator 
                                declarator: (identifier) @variable.parameter))))

"..." @variable.builtin

; Operators

[
  "^"
] @operator

; Literals

(platform) @string.special

(version_number) @markup.link.url @number

; Punctuation

"@" @punctuation.special

[ "<" ">" ] @punctuation.bracket
