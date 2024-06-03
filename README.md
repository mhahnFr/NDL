# Welcome to *NDL*!
The **N**ative **D**ark mode **L**istener (_NDL_) is a platform abstraction API. It provides a generified access to
the information whether the system user interface uses a dark theme.

## Usage
### Installation
Get started by either downloading a prebuilt library [here][2].

Alternatively, you can build the library yourself:
- Clone the repository: `git clone https://github.com/mhahnFr/NDL.git`
- Go into the cloned directory: `cd NDL/`
- And build the library: `make`

Or in one step:
```shell
git clone https://github.com/mhahnFr/NDL.git && cd NDL/ && make
```

Now, you can use the library however you like.

### API
#### Types
NDL provides the following type definition:
- `ndl_darkModeCallback` (defined as `void (*)(void)`)

The `ndl_darkModeCallback` represents a function that is called when the system user interface changes its theme.

> [!NOTE]
> The callback might be called from some arbitrary background thread.

#### Functions
NDL provides the following functions:

| Name                     | Parameters             | Return value | Description                              |
|--------------------------|------------------------|--------------|------------------------------------------|
| `ndl_queryDarkMode`      | _None_                 | `bool`       | Queries whether the UI uses a dark theme |
| `ndl_registerCallback`   | `ndl_darkModeCallback` | `bool`       | Registers the given callback function    |
| `ndl_deregisterCallback` | `ndl_darkModeCallback` | `bool`       | Unregisters the given callback function  |

#### Example
```C
// main.c

#include <stdio.h> // For printf(...)

#include <ndl.h>

static bool themeChanged = false;

static void darkModeCallback(void) {
    printf("Dark mode changed!\n");
    themeChanged = true;
}

int main(void) {
    printf("Dark mode: %s\n", ndl_queryDarkMode() ? "On" : "Off");
    
    ndl_registerCallback(darkModeCallback);
    
    // Enter the main application loop...
    if (themeChanged) {
        printf("Dark mode changed to: %s\n", ndl_queryDarkMode() ? "Dark" : "Light");
        themeChanged = false;
    }
}
```

Make sure to specify the path to the header `ndl.h` and the path to the library.

> [!NOTE]
> **Examples**:
> - **macOS**: `cc main.c -I<path/to/NDL>/include -L<path/to/NDL> -lndl`

### Platform support
This library currently supports the following platforms:
- macOS

More platforms might be added in the future - pull requests are welcome!

## Final notes
This project is licensed under the terms of the GNU LGPL in version 3 or later.

© Copyright 2024 [mhahnFr][1]

[1]: https://github.com/mhahnFr
[2]: https://github.com/mhahnFr/NDL/releases/latest