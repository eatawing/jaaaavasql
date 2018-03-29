
def theSpliter(roughList):
    categoryCol = {}
    category = ''
    workSet = None
    flag = False

    for eachLine in roughList:
        # Moving onto next category
        if eachLine.startswith("---"):
            if flag:
                categoryCol[category].remove(workSet)
                flag = False

            category = eachLine.translate(None, ' -').strip()
            categoryCol[category] = []

            workSet = {}
            categoryCol[category].append(workSet)

        # Moving onto next element in the same category
        elif eachLine == '\n':

            workSet = {}
            categoryCol[category].append(workSet)
            flag = True

        else:
            attr = eachLine[:eachLine.find(':')]
            content = eachLine[eachLine.find(':'):].strip(": ").strip()

            workSet[attr] = content

    return categoryCol


if __name__ == "__main__":
    result = {}

    with open("Car-data.txt","r") as fd:
        lines = fd.readlines()

        result = theSpliter(roughList=lines)

    with open("data.sql", "w") as sql:
        # Insert into Customer
        for element in result['Customer']:
            sql.write("insert into customer values ('{}' ,{}, '{}');\n".format(element["Name"], element["Age"], element["Email"]))
        sql.write('\n')
        for element in result['Model']:
            sql.write("insert into model values ({}, '{}', '{}', {}, {});\n".format(element["ID"], element["Name"], element["Vehicle Type"], element["Model Number"], element["Capacity (Seats)"]))
        sql.write('\n')
        for element in result['RENTALSTATION']:
            sql.write("insert into rental_station values ({}, '{}', '{}', '{}', '{}');\n".format(element["Station Code"], element["Name"], element["Address"], element["Area Code"], element["City"]))
        sql.write('\n')
        for element in result['CAR']:
            sql.write("insert into car values ({}, '{}', {}, {});\n".format(element["ID"], element["License Plate Number"], element["Station Code"], element["Model_Id"]))
        sql.write('\n')
        for element in result['RESERVATION']:
            sql.write("insert into reservation values ({}, '{}', '{}', {}, {}, '{}');\n".format(element["ID"], element["From Date"], element["To Date"], element["Car ID"], element["Old Reservation ID"], element["Status"]))
        sql.write('\n')
        for element in result['CUSTOMER_RESERVATION']:
            sql.write("insert into customer_reservation values ('{}', {});\n".format(element["Customer Email"], element["Reservation ID"]))