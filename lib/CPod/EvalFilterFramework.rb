
$filterHash_value = {}


def filterFramework(frameworks)

  $filterHash_value['filterFramework'] = frameworks

end



content = File.read './CPodfile'
eval content

