//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include "Node.h"

Define_Module(Node);

void Node::initialize()
{
    // TODO - Generated method body
    id=par("id");
    gIn=gate("gIn");
    gOut=gate("gOut");
    if(id==1)
    {
        N_PDU* message = new N_PDU();
        scheduleAt(0,message);
    }
}
int count=0;
void Node::handleMessage(cMessage *msg)
{
    // TODO - Generated method body
    N_PDU* message = check_and_cast<N_PDU*>(msg);
    if(message->isSelfMessage())
    {
        N_PDU* message = new N_PDU();
        message->setId(count++);
        message->setType("data");
        send(message,gOut);
        bubble("data sent");
    }
    else if(id==2)
    {
        N_PDU* message = new N_PDU();
        message->setId(count-1);
        message->setType("ack");
        send(message,gOut);
        bubble("ack sent");
    }
    else if(id==1)
    {
        if(count<10)
        {
            N_PDU* message = new N_PDU();
            message->setId(count++);
            message->setType("data");
            send(message,gOut);
            bubble("data sent");
        }
    }
}
