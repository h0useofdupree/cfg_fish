function jg --description 'Generate basic Java App'
  set -l groupID "com.xps"
  set -l artifactID "basic"
  set -l archetypeArtifactID "maven-archetype-quickstart"


  argparse 'h/help' 'g/groupID=' 'a/artifactID=' 'archetypeArtifactID=' -- $argv
  or return

  if set -q _flag_g
    set groupID $_flag_g
  end

  if set -q _flag_a
    set artifactID $_flag_a
  end

  if set -q _flag_aa
    set archetypeArtifactID $_flag_aa
  end
  
  mvn archetype:generate \
      -DgroupId=$groupID \
      -DartifactId=$artifactID \
      -DarchetypeArtifactId=$archetypeArtifactID \
      -DinteractiveMode=false
end
