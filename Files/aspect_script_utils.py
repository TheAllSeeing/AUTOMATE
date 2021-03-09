#!/usr/bin/env python3
from file_management_utils import *
from datetime import timedelta

def iso_today():
    return date.today() + timedelta(1)

def write(dossier, template, sort=0):
    # sort_0: day
    # sort_1: week

    assert 0 <= sort <= 1

    if sort == 0:
        file_dir = date.today().strftime('%m %B') # month_num month_name (e.g 04 April)
        file_name = date.today().strftime('%d, %A') # day_num, day_name (e.g 14, Friday)
    else:
        file_dir = date.today().strftime('%G') #<ISO Year>
        file_name = 'W' + iso_today().strftime('%V') #W<ISO Week, shifted to start on Mondays>.lyx

    file_dir =  os.path.join(convert_pathtype(dossier, 0), file_dir)

    mkdir(escape(file_dir), options="-p")

    file_base = os.path.join(file_dir, file_name)


    lyx_file = file_base + '.lyx'
    pdf_file = file_base + '.pdf'

    if not os.path.isfile(lyx_file):
        with open(os.path.join(var('TEMPLATE'), template + '.lyx'), 'r') as template:
            content = template.readlines()
            if sort == 0:
                content[content.index('DAY, MONTH ddth, yyyy\n')] = date.today().strftime(f'%A, %B %-d{ordinal_suffix()} %Y')  + '\n'
            else:
                content[content.index('Week Report #ISO\n')] = 'Week Report #' + iso_today().strftime('%V') + '\n'
                content[content.index('yyyy\n')] = iso_today().strftime('%G') + '\n'
        with open(lyx_file, 'w+') as record:
            record.write(''.join(content))
    if not os.path.isfile(pdf_file):
        os.system('lyx -e pdf ' + escape(lyx_file))
    return (lyx_file, pdf_file)
