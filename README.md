# OpenCBS: COBOL Defects Benchmark Suite

An open-source collection of COBOL programs containing real-world defects and their fixes, designed to support tool development, testing, and developer training.

## Overview

This repository contains **43 COBOL programs** recreated from actual developer questions posted in COBOL/mainframe forums. Each program demonstrates a specific defect pattern encountered by COBOL developers, particularly those new to the language.

## Purpose

- **Tool Testing**: Benchmark for evaluating COBOL development tools (debuggers, static analyzers, code comprehension tools)
- **Developer Training**: Real-world examples of common COBOL defects and their solutions
- **Research**: Publicly available dataset for empirical software engineering research

## Repository Structure

Each program includes:
- **Problem Statement**: Clear description of the defect (in file header)
- **Defective Code**: Original buggy code (commented out with `****`)
- **Fixed Code**: Corrected implementation (active code)
- **Supporting Files**: JCL scripts, data files, SQL tables as needed

## Defect Distribution

The benchmark covers various defect types:
- **Algorithm/Method** (46.5%): Logic errors, incorrect program flow
- **Assignment/Initialization** (37.2%): Variable initialization, incorrect declarations
- **Checking** (7%): Missing validation or guards
- **Interface/O-O Messages** (4.7%): Communication errors
- **Function/Class/Object** (2.3%): Structural issues
- **Relation** (2.3%): Relationship errors

## Usage

Programs are designed to be:
- Compiled and run with standard COBOL compilers (tested with Micro Focus Enterprise Developer)
- Small and focused (~100 lines) for easy comprehension
- Fully functional with all necessary dependencies included

## Data Sources

Defects were collected from:
- IBMMainframe Experts forum (6,000+ posts)
- Tek-Tips IT forum (2,500+ posts)

## Citation

If you use this benchmark in your research, please cite:
```
Dylan Lee, Austin Z. Henley, Bill Hinshaw, and Rahul Pandita. 
"OpenCBS: An Open-Source COBOL Defects Benchmark Suite"
```

## Contributing

We welcome community contributions! This benchmark represents common defects faced by beginner COBOL developers. Contributions covering intermediate and advanced defect patterns would be valuable additions.

## Community Resources

For a curated list of COBOL/mainframe communities, forums, and learning resources, see our [project website](https://github.com/PhaseChangeSoftware/cobol-defects-suite).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

This work was supported by Phase Change Software and the National Science Foundation (NSF) under Grant Nos. 1850027 and 2008408.

Special thanks to the COBOL community members who contributed to the forums from which these defects were sourced.

---

**Note**: This benchmark is actively maintained. Issues, suggestions, and contributions are encouraged!
