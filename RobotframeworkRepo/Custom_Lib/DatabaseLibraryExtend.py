from DatabaseLibrary import DatabaseLibrary
import sys
from robot.api import logger

class DatabaseLibraryExtend(DatabaseLibrary):
    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    def query(self, selectStatement, sansTran=False, returnAsDict=False):
        cur = None
        try:
            cur = self._dbconnection.cursor()
            logger.info('Executing : Query  |  %s ' % selectStatement)
            if self.db_api_module_name in ["cx_Oracle"]:
                cur.prefetchrows = 5000
                cur.arraysize = 5000
            self.__execute_sql(cur, selectStatement)
            allRows = cur.fetchall()
            if returnAsDict:
                mappedRows = []
                col_names = [c[0] for c in cur.description]
                for rowIdx in range(len(allRows)):
                    d = {}
                    for colIdx in range(len(allRows[rowIdx])):
                        d[col_names[colIdx]] = allRows[rowIdx][colIdx]
                    mappedRows.append(d)
                return mappedRows
            return allRows
        finally:
            if cur:
                if not sansTran:
                    self._dbconnection.rollback()

    def __execute_sql(self, cur, sqlStatement):
        return cur.execute(sqlStatement)
