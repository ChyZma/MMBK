# MMBK - Native Parser Component
## Requirements
* make
* clang (optionally the makefiles can be edited to use other C/C++ compilers)
## Included third party libraries
* [gif-h](https://github.com/charlietangora/gif-h)
## How to use?
Currently the parser functions as a CLI tool which takes the input CAFF file, and two destinations for the output GIF and metadata.
In the future we plan to use it as a shared library in a C# backend, which will require some modifications in the function return data types (and additional getters and setters).
* Building and running the tests:
  ```
  # In the parser folder
  make tests
  ```
* Building the parser:
  ```
  # In the parser folder
  make parser
  ```
* Running the parser:
  ```
  mmbk $CAFF_PATH $OUT_GIF_PATH $OUT_INI_PATH
  ```
  * Example:
    ```
    # In the parser folder
    ./build/parser/mmbk assets/tests/1.caff test.gif test.ini
    ```

## Return values
| Return code | Meaning                                |
|-------------|----------------------------------------|
| 0           | Gif and metadata generation successful |
| 11          | Wrong number of arguments              |
| 12          | Couldn't open CAFF file                |
| 21          | Multiple header blocks                 |
| 22          | Multiple credits blocks                |
| 23          | Missing header or credit block         |
| 24          | CAFF magic wrong                       |
| 25          | Wrong CAFF header size                 |
| 26          | Wrong creation date                    |
| 27          | Wrong creator length                   |
| 28          | wrong CAFF block ID                    |
| 29          | Wrong CAFF block length                |
| 31          | GIF generation failed                  |
| 41          | CIFF magic wrong                       |
| 42          | CIFF content size wrong                |
