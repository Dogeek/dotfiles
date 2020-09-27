from lxml import etree
import argparse


parser = argparse.ArgumentParser()
parser.add_argument('filepath')
parser.add_argument('item')
parser.add_argument('--keep', type=int, default=0)
parser.add_argument('--encoding', default='utf-8')

args = parser.parse_args()


with open(args.filepath) as f:
    root = etree.parse(f)

element = [e for e in root.iter() if e.attrib.get('name')==args.item][0]
x = [e.attrib['name'] for e in element.iter()]
duplicates = [n for n in x if x.count(n) > 1]
for dupe in duplicates:
    elems = root.xpath(f'//style[@name="{args.item}"]//item[@name="{dupe}"]')
    parent = elems[0].getparent()
    for i, el in enumerate(elems):
        if i != args.keep:
            parent.remove(el)

with open(args.filepath, 'w') as f:
    f.write(etree.tostring(root, encoding=args.encoding, pretty_print=True).decode(args.encoding))
