 
[System.Reflection.Assembly]::LoadWithPartialName("System.Linq")
function getProcessableObjects($dataItems){
    $items = new-object System.Collections.Generic.List[PSObject]; 
    $item;
    $dataItems | %{ 
        $item = $_;
        $_.fields | % {
            $res = @{ Category = $item.category}; 
        } {
        $res[$_.label] = $_.value
        } { 
            $res.Category = $item.category;
            $res.Title = $item.Title;
            $res.Note = $item.note;
            $res.version = $null;
            $items.add($res)
        } 
    }
    return $items;
}

function getNote([PSObject]$data){
    #title,text of note
    getProcessableObjects $data.items | ?{ $_.category -eq "note"} | select-object -property title,note | convertto-csv
}

function getLogin([PSObject]$data){
    # title,website,username,password,notes
    getProcessableObjects $data.items | ?{ $_.category -eq "login"} |  select-object -property Title, Url, Username, Password | convertto-csv
}

function getLicense([PSObject]$data){
    # title,version,license key,your name,your email,company,download link,software publisher,publisher's website,retail price,support email,purchase date,order number,notes
    $items = getProcessableObjects $data.items;
    $items | ?{ $_.category -eq "license"} | select-object -property title,version,note | convertto-csv 
}
