#set page(margin: 1cm, columns: 2)
#set raw(syntaxes: "flex.sublime-syntax", lang: "flex")


= Flex Language Specification

== Type System

Statically Typed

=== Built-in Type

- `Void`
- `Any` (tentative)
- `Never` (tentative)
- `Bool`
- `Char` (UTF-32)
- `String` (UTF-8)
- #table(
    align: center + horizon,
    columns: 2,
    table.cell(colspan: 2)[Numeric Type],
    [`Int8`], [`UInt8`],
    [`Int16`], [`UInt16`],
    [`Int32` / `Int`], [`UInt32` / `UInt`],
    [`Int64`], [`UInt64`],
    table.cell(colspan: 2)[`Float32` / `Float`],
    table.cell(colspan: 2)[`Float64`],
  )

=== Composite Type

- Tuple: `(T, T)`
- Struct: `(x: T, y: T)`
- Array: `[T]`
- Map: `[T1:T2]`
- Function: `(T, T) => T` or `(x: T, y: T) => T`
- Enum: `{ A, B: (T, T), C: (x: T, y: T) }` (tentative)

== Declaration

=== Variable

- Mutable Variable: `var x`
- Immutable Variable: `const x`
- Compile-Time Variable: `def x`

=== Function

`def f = { (x: T, y: T) => x + y }`

=== Type

`def Int = Int32`

`def A = (x: T, y: T)`

`def A = (
  x: T,
  y: T,
)`

`def A = (T, T)`

== Expression

=== Literal

- `Void`: `void`
- `Bool`: `true` / `false`
- `Char`: `'c'`
- `String`: `"string"`
- #table(
    align: center + horizon,
    columns: 2,
    table.cell(colspan: 2)[Numeric Type],
    [`Int8`: `0i8`], [`UInt8`: `0u8`],
    [`Int16`: `0i16`], [`UInt16`: `0u16`],
    [`Int32`: `0i32`], [`UInt32`: `0u32`],
    [`Int`: `0` / `0i`], [`UInt`: `0` / `0u`],
    [`Int64`: `0i64`], [`UInt64`: `0u64`],
    table.cell(colspan: 2)[`Float32`: `0.0f32`],
    table.cell(colspan: 2)[`Float`: `0.0` / `0.0f`],
    table.cell(colspan: 2)[`Float64`: `0.0f64`],
  )
- Tuple: `(1, 2)`
- Struct: `(x: 1, y: 2)`
- Array: `[1, 2, 3]`
- Map: `[x: 1, y: 2, z: 3]`
- Function: `{ x: T, y: T => x + y }`

// == Control Flow
