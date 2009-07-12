#
# Cookbook Name:: jruby2
# Attributes:: jruby
#
# Copyright 2008, OpsCode, Inc.
#
# Licensed under the jruby License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.jruby.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

jruby Mash.new unless attribute?("jruby")

###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

jruby[:version] = "1.3.1"  unless jruby.has_key?(:version)
jruby[:prefix] = "/opt"  unless jruby.has_key?(:prefix)
