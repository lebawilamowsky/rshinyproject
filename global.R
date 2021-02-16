library(shiny)
library(dplyr)
library(ggplot2)
library(googleVis)
library(tidyr)
library(lubridate)
library(DT)
library(shinydashboard)

setwd('~/Desktop/Rshinyproject')
uberdata = read.csv('UberRequestData.csv')
uberdata = uberdata[, 2:5]
uberdata = separate(uberdata, Request.timestamp, c('date', 'time'), sep = " ")
class(uberdata$time)
uberdata$time = sub(":.*", "", uberdata$time)
uberdata = uberdata %>% rename(hour = time)
uberdata$hour = as.numeric(uberdata$hour)
uberdata$timeofday = ifelse(uberdata$hour < 4,
                            '12AM-3:59AM',
                            ifelse(
                              uberdata$hour < 8,
                              '4AM-7:59AM',
                              ifelse(
                                uberdata$hour < 12,
                                '8AM-11:59AM',
                                ifelse(
                                  uberdata$hour < 16,
                                  '12PM-3:59PM',
                                  ifelse(uberdata$hour < 20, '4PM-7:59PM', '8PM-11:59PM')
                                )
                              )
                            ))

forgvA = uberdata %>% filter(Pickup.point == 'Airport') %>% mutate(timeofday = factor(
  timeofday,
  level = c(
    '12AM-3:59AM',
    '4AM-7:59AM',
    '8AM-11:59AM',
    '12PM-3:59PM',
    '4PM-7:59PM',
    '8PM-11:59PM'
  )
)) %>% group_by(timeofday) %>% summarize(
  "Requests Completed" = sum(Status == "Trip Completed"),
  "Total Requests" = sum(Status != '')
)

forgvC = uberdata %>% filter(Pickup.point == 'City') %>% mutate(timeofday = factor(
  timeofday,
  level = c(
    '12AM-3:59AM',
    '4AM-7:59AM',
    '8AM-11:59AM',
    '12PM-3:59PM',
    '4PM-7:59PM',
    '8PM-11:59PM'
  )
)) %>% group_by(timeofday) %>% summarize(
  "Requests Completed" = sum(Status == "Trip Completed"),
  "Total Requests" = sum(Status != '')
)