# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [v2.0.0] - 2026-05-04

### Changed
- 使用 expl3 完全重写文档类
- 新的键值接口 `\sdusetup{}`，替代旧的命令式接口
- 仅支持 XeLaTeX 引擎，移除 pdfTeX/DVI 分支
- 构建系统从自定义脚本迁移到 l3build
- 封面和承诺书模块使用 expl3 重写
- 用户文档使用 ctxdoc 排版，采用 Noto CJK 字体
- 合并 sduthesis.ins 到自解压 sduthesis.dtx

### Added
- l3build 回归测试（选项、元数据、兼容性）
- GitHub Actions CI（测试 + 发版工作流）
- DEPENDS.txt 依赖声明
- 兼容层：旧命令（`\Ctitle`、`\Cauthor` 等）保留但发出废弃警告

### Removed
- 移除 `tabu` 依赖，改用 `longtable` + `booktabs`
- 移除 `ifpdf`/`ifxetex` 条件分支
- 移除独立的 sduthesis.ins 文件

## [v1.3.0a] - 2016-01-11

### Fixed
- 兼容新版本 CTeX 宏集

## [v1.3.0] - 2015-12-05

### Changed
- 重构了构建系统

## [v1.2.0b] - 2014-01-04

### Changed
- 重新构建了用户文档和演示文档

## [v1.2.0a] - 2014-01-01

### Changed
- 使用 DocStrip 工具重新实现

## [v1.0] - 2013-05-12

### Added
- 首次公开

[Unreleased]: https://github.com/liam0205/sduthesis/compare/v2.0.0...HEAD
[v2.0.0]: https://github.com/liam0205/sduthesis/compare/v1.3.0a...v2.0.0
[v1.3.0a]: https://github.com/liam0205/sduthesis/compare/v1.3.0...v1.3.0a
[v1.3.0]: https://github.com/liam0205/sduthesis/compare/v1.2.0b...v1.3.0
[v1.2.0b]: https://github.com/liam0205/sduthesis/compare/v1.2.0a...v1.2.0b
[v1.2.0a]: https://github.com/liam0205/sduthesis/compare/v1.0...v1.2.0a
[v1.0]: https://github.com/liam0205/sduthesis/releases/tag/v1.0
