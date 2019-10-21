#' api_getuploads
#'
#' @param mid The member id
#' @param kw keyword used for filtering
#'
#' @return a dataframe of all uploaded videos of mid
#' @export
#'
#' @examples
#' getvlist(5382023,kw="aaa")
#' @importFrom jsonlite fromJSON
api_getuploads <- function(mid, kw = "") {
  fpurl = paste0(
    "https://space.bilibili.com/ajax/member/getSubmitVideos?mid=",
    mid,
    "&pagesize=100&tid=0&page=1&keyword=",
    kw,
    "&order=pubdate"
  )

  test2 <- fromJSON(fpurl)
  vlist.df <- test2$data$vlist
  message(paste0("pages received: ",test2$data$pages))
  if (test2$data$pages > 1)
  {
    for (i in 2:test2$data$pages) {
      Sys.sleep(1)
      aurl = paste0(
        "https://space.bilibili.com/ajax/member/getSubmitVideos?mid=",
        mid,
        "&pagesize=100&tid=0&page=",
        i,
        "&keyword=",
        kw,
        "&order=pubdate"
      )
      ajson <- fromJSON(aurl)
      avlist <- ajson$data$vlist
      vlist.df <- rbind(vlist.df, avlist)
    }
  }
  return(vlist.df)
}



#' api_getuploads
#'
#' @param mid up's member id
#' @param kw keyword for filtering results
#'
#' @return a dataframe of all uploaded videos of mid
#' @export
#'
#' @examples
#' api_getuploads_fp(5382023)
#' @importFrom jsonlite fromJSON
#'
api_getuploads_fp <- function(mid, kw = "") {
  fpurl = paste0(
    "https://space.bilibili.com/ajax/member/getSubmitVideos?mid=",
    mid,
    "&pagesize=5&tid=0&page=1&keyword=",
    kw,
    "&order=pubdate"
  )
  test2 <- fromJSON(fpurl)
  vlist.df <- test2$data$vlist
  return(vlist.df)
}

#' get tags of a video
#'
#' @param aid aid ov the video
#'
#' @return list
#' @export
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' # https://www.bilibili.com/video/av2441580/
#' api_gettags(aid = 2441580)
api_gettags <- function(aid = 3653764, sleep = 1.0) {
  Sys.sleep(sleep)
  url = "https://api.bilibili.com/x/tag/archive/tags?"
  url.aid = paste0(url, "&aid=", aid)
  test.tags <- fromJSON(url.aid)
#  tagv <- paste(test.tags$data$tag_name,collapse=";")
  tagv <-list(test.tags$data$tag_name)
  return(tagv)
}


#' get danmaku of a video
#'
#' @param cid cid of the video
#'
#' @return list
#' @export
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' # https://www.bilibili.com/video/av2441580/
#' api_getdanmaku(cid = 5846059)
#'
api_getdanmaku= function(cid=5846059){
  url = "https://api.bilibili.com/x/v1/dm/list.so?oid="

  url.cid = paste0(url, cid)
  resp = fromJSON(url.cid)
  return(resp)
}


#' test if a video is alive
#'
#' @param aid one aid at a time.
#' @param sleep interval of quest if multiple aid is supplied
#'
#' @return response code
#' @export
#'
#' @examples api_is_aid_alive(aid = 56447372, sleep = 1.0)
#'
api_is_aid_alive = function(aid = 56447372, sleep = 1.0){
  Sys.sleep(sleep)
  # url2 =paste0("http://api.bilibili.com/x/reply?type=1&oid=",aid)
  url = paste0("https://api.bilibili.com/x/web-interface/archive/stat?aid=",aid)
  rslt = jsonlite::fromJSON(url)$code
  return(rslt)
}
