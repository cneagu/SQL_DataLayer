using Sql_DataLayer;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace DataLayer_Test
{
    class Program
    {
        static void Main(string[] args)
        {
            string conectionString = "Server=.;Database=KruzeAutoDB;Trusted_Connection=True;";

            User user = new User
            {
                CreationDate = new DateTime(2012, 2, 2),
                Password = "sadda",
                Email = "new@new.com",
                PhoneNumber = "sdad",
                Subscribed = true,
                UserID = new Guid("e5c24e7a-a819-1e62-e37c-0700402a1b23"),
                UserName = "plm"
            };
            User user3 = new User
            {
                CreationDate = new DateTime(2012, 5, 2),
                Password = "alala",
                Email = "new@ne2w.com",
                PhoneNumber = "sdaad",
                Subscribed = true,
                UserID = new Guid("e5c24e7a-a819-2e62-e37c-0700402a1b23"),
                UserName = "new user name"
            };
            Guid userId1 = new Guid("e5c24e7a-a819-1e62-e37c-0700402a1b8c");

            //sql Parameter tests
            SqlParameter[] userToSqlParameters = SQL_DataAccess.CreateSQLParameterList(user).ToArray();
            SqlParameter[] userID1 = { SQL_DataAccess.CreateSQLParameter("UserID", new Guid("bc16cb00-4c2d-493b-bc43-a2acb3654081")) };
            SqlParameter[] userID2 = { SQL_DataAccess.CreateSQLParameter("UserID", new Guid("e5c24e7a-a819-1e62-e37c-0700402a1b23")) };
            SqlParameter[] UserID3 = { SQL_DataAccess.CreateSQLParameter("UserID", new Guid("e5c24e7a-a819-2e62-e37c-0700402a1b23")) };

            // Testing Procedure SQL
            Console.WriteLine("Print all users \n");
            List<User> users = SQL_DataAccess.ReadWithProcedure<User>("[Users_ReadAll]", conectionString);
            Display<User>(users);

            Console.WriteLine("Inser User \n");
            int nrOfUsers = (int)SQL_DataAccess.ExecuteScalar("SELECT Count(*) FROM [Users] ", conectionString);
            Console.WriteLine("\n number of Users before insert is {0} \n", nrOfUsers);
            SQL_DataAccess.ExecuteNonQueryWithProcedure("dbo.Users_DeleteByID", conectionString, userID2);
            SQL_DataAccess.ExecuteNonQueryWithProcedure("dbo.Users_Insert", conectionString, userToSqlParameters);

            //Testing scalar operations
            int nrOfUsers1 = (int)SQL_DataAccess.ExecuteScalar("SELECT Count(*) FROM [Users] ", conectionString);
            Console.WriteLine("\n number of Users after insert is {0} \n", nrOfUsers1);

            SQL_DataAccess.ExecuteNonQueryWithProcedure("dbo.Users_DeleteByID", conectionString, userID1);
            int nrOfUsers2 = (int)SQL_DataAccess.ExecuteScalar("SELECT Count(*) FROM [Users] ", conectionString);
            Console.WriteLine("\n number of Users after delete is {0} \n", nrOfUsers2);

            //Testing Query SQL
            List<User> user2 = SQL_DataAccess.Read<User>(string.Format("Select * from [Users] where [UserID] = {0}", SqlValueConverter.ToSqlValue(userId1)), conectionString);
            Console.WriteLine("User from query is \n");
            Display<User>(user2);

            SQL_DataAccess.ExecuteNonQuery("INSERT INTO [Users]([UserID],[Email],[UserName],[Password],[PhoneNumber],[CreationDate],[Subscribed])"
                + " VALUES('bc16cb00-4c2d-493b-bc43-a2acb3654081', 'manu_lacu@yahoo.ro', 'new', 'new', '0765767186', '2016-02-06 10:19', '1')", conectionString);

            int nrOfUsers3 = (int)SQL_DataAccess.ExecuteScalar("SELECT Count(*) FROM [Users] ", conectionString);
            Console.WriteLine("\n number of Users after insert is {0} \n", nrOfUsers3);

            //insert and update 
            SQL_DataAccess.ExecuteNonQueryWithProcedure("dbo.Users_DeleteByID", conectionString, UserID3);
            SQL_DataAccess.Insert(user3, "Users", conectionString);

            int nrOfUsers4 = (int)SQL_DataAccess.ExecuteScalar("SELECT Count(*) FROM [Users] ", conectionString);
            Console.WriteLine("\n number of Users after insert and delete is {0} \n", nrOfUsers4);

            List<User> firstInsertUser3 = SQL_DataAccess.Read<User>(string.Format("Select * from [Users] {0}", SQL_DataAccess.CreateWhereClause("UserID", SqlValueConverter.ToSqlValue(user3.UserID))), conectionString);
            
            Console.WriteLine("User from insert is \n");
            Display<User>(firstInsertUser3);

            SQL_DataAccess.Update(user3, "Users", SQL_DataAccess.CreateWhereClause("UserID", SqlValueConverter.ToSqlValue(user3.UserID)), conectionString);

            List<User> user3AfterUpdate = SQL_DataAccess.Read<User>(string.Format("Select * from [Users] {0}", SQL_DataAccess.CreateWhereClause("UserID", SqlValueConverter.ToSqlValue(user3.UserID))), conectionString);

            Console.WriteLine("User from update is \n");
            Display<User>(user3AfterUpdate);

            List<User> users2 = SQL_DataAccess.ReadWithProcedure<User>("[Users_ReadAll]", conectionString);

            Console.WriteLine("User final is \n");
            Display<User>(users2);

            Console.ReadLine();
        }


        public static void Display<T>(object objs)
        {
            var t = typeof(T);
            var props = t.GetProperties();
            foreach (var obj in objs as IEnumerable<T>)
            {
                StringBuilder sb = new StringBuilder();
                foreach (var item in props)
                {
                    sb.Append($"{item.Name}:{item.GetValue(obj, null)}; ");
                    sb.AppendLine();
                }
                Console.WriteLine(sb.ToString());
            }
        }
    }
}
