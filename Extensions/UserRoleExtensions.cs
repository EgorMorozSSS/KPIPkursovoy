using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Course.Models;

namespace Course.Extensions
{
    public class UserRoleExtensions
    {
        public static IEnumerable<UserRoleItem> Values =>
        Enum.GetValues(typeof(UserRole))
            .Cast<UserRole>()
            .Select(r => new UserRoleItem(r));

        public class UserRoleItem
        {
            public UserRole Value { get; }
            public string Name => Value.ToString();

            public UserRoleItem(UserRole role)
            {
                Value = role;
            }
        }
    }
}
