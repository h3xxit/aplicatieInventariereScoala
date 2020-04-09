using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Aplicatie_Inventariere.DTO
{
    class ObjectDto
    {
        private string name, room;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public string Room
        {
            get { return room; }
            set { room = value; }
        }

        public ObjectDto(string name, string room)
        {
            this.name = name;
            this.room = room;
        }
    }
}
