
# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2018-07-05

### Added

- Add documents for english language.

### Changed

- Rename `+[EZSequence zip:]`  to `+[EZSequence zipSequences:]`.
- Rename `+[EZSequence concat:]` to `+[EZSequence concatSequences:]`.

### Fixed

- Optimize `EZSQueue` performance.

## [1.2.1]

### Added

- Add EZS_instanceEqual useful block.

### Fiexed

- Fix bug for removeObjectAtIndex: method.

## [1.2.0]

### Added

- Add EZS_performSelector, EZS_mapWithSelector useful blocks.
- Add removeAllObjects method for EZSArray and EZSOrderedSet.
- Add concat, flatten, zip method for EZSequences.

### Fixed

- Fix crash while enumerating a sequence.

## [1.1.0] 

### Added

- Add Generic support for EZSWeakArray, EZSWeakOrderedSet.
- Add EZSWeakReference and NSObject+EZSDeallocBell helper classes.

## [1.0.0]

### Added

- First version. See also README.md.
