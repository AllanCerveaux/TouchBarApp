# Custom TouchBar App

A macOS application that allows you to customize and control the Touch Bar.

## Features

- Custom Touch Bar configurations
- System-wide Touch Bar control
- Status bar integration
- Dynamic Touch Bar item management
- Extensible architecture for custom items

## Development

### Requirements

- macOS 10.14+
- Xcode 12.0+
- Swift 5.0+

### Building

1. Clone the repository
2. Open the project in Xcode
3. Build and run the project

## Build and Run

### Prerequisites

- macOS 11.0 or later
- Xcode 12.0 or later
- Swift 5.3 or later

### Instructions

1. Clone the project:
```bash
git clone https://github.com/your-username/custom-touchbar.git
cd custom-touchbar
```

2. Build the project:
```bash
swift build
```

3. Run the application:
```bash
swift run
```

For development, you can also use:
```bash
# Debug mode
swift build -c debug
swift run -c debug

# Release mode
swift build -c release
swift run -c release
```

### Troubleshooting

If you encounter a "Permission denied" error when running:
```bash
chmod +x .build/debug/TouchBarApp
.build/debug/TouchBarApp
```

## Project Structure

```
Sources/
└── TouchBarApp/
    ├── Application/
    ├── Features/
    │   ├── StatusBar/
    │   └── TouchBar/
    │       ├── Configurations/
    │       ├── Core/
    │       ├── Extensions/
    │       ├── Items/
    │       │   ├── Base/
    │       │   ├── Button/
    │       │   ├── Label/
    │       │   └── Group/
    │       └── Protocols/
    └── Utils/
```

## Architecture

The project follows Clean Architecture principles and SOLID design patterns:

### Core Components

- **TouchBarManager**: Central manager for Touch Bar state and configurations
- **TouchBarFactory**: Factory pattern implementation for Touch Bar items
- **TouchBarMonitor**: Observer pattern implementation for Touch Bar state changes
- **StatusBarController**: Manages the system status bar integration

### Design Patterns

- **Factory Pattern**: For Touch Bar item creation
- **Observer Pattern**: For Touch Bar state monitoring
- **Protocol-Oriented**: Extensive use of protocols for flexibility
- **Dependency Injection**: For loose coupling between components

## Code Style

The project follows Swift's official style guide and best practices:

- Protocol-oriented programming
- Value types over reference types when appropriate
- Clear separation of concerns
- Comprehensive documentation
- Strong type safety

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details