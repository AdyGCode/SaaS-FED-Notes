## Using `packages.conf` on NMTAFE Computers

The supplied `packages.conf` file tells Laragon about the packages that are available for download and installation through Laragon.

You do **not** install another copy of Laragon on an NMTAFE computer.

NMTAFE computers already have Laragon installed.

### 1. Locate the NMTAFE Laragon Installation

On most NMTAFE computers, Laragon is installed under:

```text
C:\ProgramData\
```

In some TDM network laboratories, including environments such as Room 3-06, Laragon may instead be installed under:

```text
C:\
```

The exact location may vary between teaching rooms.

If you are unsure, start Laragon and ask your lecturer to confirm the installation location.

---

### 2. Locate the `usr` Folder

Inside the Laragon installation, locate:

```text
laragon\usr\
```

For example, your installation may contain:

```text
C:\ProgramData\laragon\usr\
```

or:

```text
C:\laragon\usr\
```

Do not assume that `C:\laragon` is used on every NMTAFE computer.

---

### 3. Locate the Existing Configuration

Look inside:

```text
laragon\usr\
```

for:

```text
packages.conf
```

If an existing file is present, do not immediately delete it.

Keep a copy of the original configuration if your environment allows this.

For example:

```text
packages.conf
packages.conf.backup
```

---

### 4. Copy the Supplied Configuration

Copy the supplied:

```text
packages.conf
```

into:

```text
<laragon-installation>\usr\
```

The final location should therefore be similar to:

```text
<laragon-installation>\usr\packages.conf
```

For example:

```text
C:\laragon\usr\packages.conf
```

The exact path depends on the NMTAFE laboratory.

---

### 5. Restart Laragon

If Laragon is currently running:

1. Exit Laragon.
2. Start Laragon again.
3. Allow Laragon to reload its configuration.

Do not reinstall Laragon.

---

### 6. Open Laragon Quick Add

Open the Laragon menu and locate:

```text
Tools
    ↓
Quick add
```

The available packages are determined by the entries in:

```text
packages.conf
```

You should now be able to locate the required package from the Quick Add menu.

Your lecturer will tell you which package is required for the current activity.

---

### 7. Install Only the Required Package

Select only the package required for the class activity.

Laragon should:

```text
Read packages.conf
        ↓
Locate the package definition
        ↓
Download the package
        ↓
Extract it into Laragon
        ↓
Make it available to Laragon
```

Do not install or update unrelated packages.

---

### 8. Restart and Verify

After the package has been added:

1. Exit Laragon.
2. Restart Laragon.
3. Check that the new package is available.
4. Start the required service if appropriate.

Your lecturer may provide an additional command or verification step for the particular package being installed.

---

## Important — NMTAFE Computers

NMTAFE computers are managed and locked down.

Do not attempt to:

- Install another copy of Laragon.
- Run the Laragon installer.
- Change system-wide Windows configuration.
- Install unrelated software.
- Modify protected NMTAFE folders.
- Use administrator workarounds.
- Replace configuration files other than those instructed by your lecturer.

If Windows prevents you from copying `packages.conf` into the Laragon installation, **stop and ask your lecturer**.

Do not attempt to bypass NMTAFE permissions.

---

## What Does `packages.conf` Do?

The file does not install software by itself.

It provides Laragon with package definitions that can be used by its package management features.

Think of the process as:

```text
packages.conf
      ↓
Laragon reads available packages
      ↓
Quick Add
      ↓
Select required package
      ↓
Laragon downloads and extracts it
```

This allows the NMTAFE Laragon environment to be extended without students installing a completely new Laragon environment.

---

## Troubleshooting

### The `usr` folder cannot be found

Check that you are looking inside the NMTAFE Laragon installation.

Possible locations include:

```text
C:\ProgramData\...
```

or:

```text
C:\Laragon\...
```

Ask your lecturer if the laboratory uses a different location.

### Windows will not allow the file to be copied

Do not change permissions.

Ask your lecturer.

### Quick Add does not show the expected package

Check that:

```text
packages.conf
```

is located directly inside:

```text
laragon\usr\
```

Then completely exit and restart Laragon.

### The package downloads but does not work

Do not repeatedly reinstall it.

Check:

1. Laragon has been restarted.
2. The correct package/version was selected.
3. The package appears in the appropriate Laragon location.
4. Any package-specific setup supplied by your lecturer has been completed.

If the problem remains, ask your lecturer.

---

## Home / BYOD Computers

These instructions are specifically for **NMTAFE-managed computers**.

Home and BYOD installations may use a different Laragon location and may allow installation or configuration changes that are not permitted on NMTAFE systems.

Follow the separate Home/BYOD instructions where provided.
