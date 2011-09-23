#!/usr/bin/env ruby
# taken from: http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
git_bundles = [ 
  "git://github.com/astashov/vim-ruby-debugger.git",
  "git://github.com/msanders/snipmate.vim.git",
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/timcharper/textile.vim.git",
  "git://github.com/tpope/vim-cucumber.git",
  "git://github.com/tpope/vim-fugitive.git",
  "git://github.com/tpope/vim-git.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-rails.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/tsaleh/vim-align.git",
  "git://github.com/tsaleh/vim-shoulda.git",
  "git://github.com/tsaleh/vim-supertab.git",
  "git://github.com/tsaleh/vim-tcomment.git",
  "git://github.com/vim-ruby/vim-ruby.git",
  "git://github.com/ecomba/vim-ruby-refactoring.git",
]

vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["gist",          "12732", "plugin"],
  ["jquery",        "12107", "syntax"],
  ["MRU", "521", 'plugin'],
#  ["ttcoach", "461", "plugin" ],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

install = true 

if false 
        FileUtils.cd(bundles_dir)
	puts "Trashing everything (lookout!)"
	Dir["*"].each {|d| FileUtils.rm_rf d }
	FileUtils.cd('..')
end

git_bundles.each do |url|
  fullname = url.split('/').last.sub(/\.git$/, '')
  dir = fullname.sub(/vim-/,'')
	dirname =  "bundle/#{dir}"
	puts "checking #{dirname}"
  if !File.exists?(dirname)|| Dir.entries(dirname).length == 2
     puts "  Unpacking #{url} into bundle/#{dir}"
     if install 
    `git submodule add #{url} bundle/#{dir}`
    `git add .`
    `git commit -m "Install #{fullname} as a submodule"`
    #FileUtils.rm_rf(File.join(dir, ".git"))
     end
  end  
end

vim_org_scripts.each do |name, script_id, script_type|
	puts "checking script #{name}"
	dirname =  "bundle/#{name}"
  if !File.exists?(dirname) || Dir.entries(dirname).length == 2
    puts "  Downloading #{name}"
    if install
    local_file = "bundle/" + File.join(name, script_type, "#{name}.vim")
    puts "Copying #{local_file} from http://www.vim.org/scripts/download_script.php?src_id=#{script_id}"
    FileUtils.mkdir_p(File.dirname(local_file))
    File.open(local_file, "w") do |file|
      file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
    end
    end
  end
end

