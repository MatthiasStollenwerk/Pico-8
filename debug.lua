-- Tracing and Logging System for Pico-8 with Log Reset

local LogLevel = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    NONE = 5
}

local currentLogLevel = LogLevel.DEBUG
local logFileName = "gobgob.log" -- name of the log file

-- Function to reset and initialize the log file
function resetLogFile()
    printh("", logFileName, true) -- overwrite the existing file
    logInfo("Log file reset and initialized.")
end

-- Function to set the log level
function setLogLevel(level)
    currentLogLevel = level
end

-- Internal function to log a message if the level is appropriate
local function log(level, message)
    if level >= currentLogLevel then
        local logMessage = "LOG [" .. level .. "]: " .. message
        printh(logMessage, logFileName, false) -- true to append to the file
    end
end

-- Public functions for different log levels
function logDebug(message)
    log(LogLevel.DEBUG, "DEBUG: " .. message)
end

function logInfo(message)
    log(LogLevel.INFO, "INFO: " .. message)
end

function logWarn(message)
    log(LogLevel.WARN, "WARN: " .. message)
end

function logError(message)
    log(LogLevel.ERROR, "ERROR: " .. message)
end


