#!/usr/bin/env python


class FetchExternalIPError(Exception):
    def __init__(self, message):
        super(FetchExternalIPError, self).__init__()
        self.message = message
