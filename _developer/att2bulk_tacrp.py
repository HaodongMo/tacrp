import glob, os, argparse

parser = argparse.ArgumentParser(description='Generates a bulk attachment file from multiple individual TacRP attachment files.')
parser.add_argument('files', nargs='+', help='File names to search (supports wildcards)')
parser.add_argument('--output_file', '-o', nargs='?', help='Output file name', default='bulk')
parser.add_argument('--use_regions', '-r', help='Generate #region tags for use with VS Code extenion "maptz.regionfolder".', action='store_true')
parser.add_argument('--dry_run', '-d', help='do not generate file, instead list included files', action='store_true')

args = parser.parse_args()

output_name = args.output_file
if output_name[:-4] != '.lua':
    output_name = output_name + '.lua'

content = f"-- {output_name}\n\nlocal ATT = {{}}\n\n"

count = 0

for prefix in args.files:
    for attpath in glob.glob(prefix + '.lua'): # process
        attlua = open(attpath, 'r')
        attname = os.path.basename(attpath)[:-4]
        content = content + ('------------------------------\n'
                            '-- ' + ('#region ' if args.use_regions else '') + attname +
                            '\n------------------------------\n'
                            'ATT = {}\n\n' +
                            attlua.read() +
                            '\n\nTacRP.LoadAtt(ATT, "' + attname + '")\n' +
                            ('-- #endregion\n\n' if args.use_regions else '\n'))
        attlua.close()
        count += 1
        if args.dry_run:
            print(attname)

if args.dry_run:
    lines = len(content.split('\n'))
    print(f'Found {count} attachments with a total line count of {lines}.')
else:
    bulk = open(output_name, 'w+')
    bulk.write(content)
    bulk.close()
    print(f'Generated {output_name} bulk file with {count} attachments.')
