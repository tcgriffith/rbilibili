# A collection of wrapper functions to interact with the official bilibili api.

## What

It seems that the official bilibili api doc is down(~~again~~), So I collected all the working apis I found and wrapped them in this package.

It contains the following utilities:


- `api_getuploads`, retrieve info of all videos from an up.
- `api_gettags`, retrieve tags of a video
- `api_getdanmaku`, retireve danmaku of a video
- `api_is_aid_alive`, test whether a video is alive


## Installation

```
remotes::install_github("tcgriffith/rbilibili")
```

## How to Use

See the documentation of each exported functions. For example,  `help(rbilibili::api_getuploads)`.
