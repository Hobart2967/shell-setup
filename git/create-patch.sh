#!/bin/bash
create-patch() {
  git format-patch -1 HEAD
}