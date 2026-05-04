# The `sduthesis` Class / `sduthesis` 文档类

## Introduction / 介绍

The `sduthesis` (v2.0.0) is designed for bachelor thesis of Shandong Univ., P.R.China,
by [Liam Huang][liam-ctan]. Starting from v2.0.0, the class is rewritten in `expl3`
with `l3keys` for option and metadata handling. Only XeLaTeX is supported.

This work is released under the LaTeX Project Public License, v1.3c or later.
See the License file.

`sduthesis`（v2.0.0）是由 [Liam Huang][liam-ctan] 为山东大学学生设计的学士学位论文
LaTeX 模板。自 v2.0.0 起，模板使用 `expl3` 重写，仅支持 XeLaTeX 编译。

`sduthesis` 遵循不低于 1.3 版本的 LPPL 许可证，详情请查看 LICENSE 文件。

## Build / 构建

The project uses `l3build` for building and testing:

    l3build unpack   # extract .cls and .def files
    l3build doc      # build the user manual
    l3build check    # run regression tests

## Usage / 用法

```latex
\documentclass{sduthesis}

\sdusetup{
  info = {
    title      = {论文题目},
    author     = {姓名},
    student-id = {学号},
    school     = {学院},
    major      = {专业},
    grade      = {年级},
    supervisor = {指导老师},
    date       = {\today},
  }
}

\begin{document}
\maketitlepagestatement
\tableofcontents
\end{document}
```

See the user manual `sduthesis.pdf` and the demo `sduthesis-demo.tex`.

参见用户文档 `sduthesis.pdf` 及示例文件 `sduthesis-demo.tex`。

### Class options / 类选项

| Option    | Values                  | Default     |
|-----------|-------------------------|-------------|
| `style`   | `chinese`, `plain`      | `chinese`   |
| `print`   | `true`, `false`         | `false`     |
| `twoside` | `true`, `false`         | `true`      |
| `degree`  | `bachelor`, `master`, `doctor` | `bachelor` |

Legacy options (`chsstyle`, `nochsstyle`, `print`, `noprint`, `double`, `single`)
are still accepted but emit deprecation warnings.

## Author / 作者

Liam Huang

Email: liamhuang0205+sduthesis@gmail.com

<https://github.com/Liam0205/sduthesis>

[liam-ctan]: http://www.ctan.org/author/huang-l
