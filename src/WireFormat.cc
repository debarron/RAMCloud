/* Copyright (c) 2011-2012 Stanford University
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR(S) DISCLAIM ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL AUTHORS BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include "WireFormat.h"
#include "Buffer.h"

namespace RAMCloud {
namespace WireFormat {

/**
 * Returns a string representation of a ServiceType.  Useful for error
 * messages and logging.
 */
const char*
serviceTypeSymbol(ServiceType type) {
    switch (type) {
        case MASTER_SERVICE:        return "MASTER_SERVICE";
        case BACKUP_SERVICE:        return "BACKUP_SERVICE";
        case COORDINATOR_SERVICE:   return "COORDINATOR_SERVICE";
        case PING_SERVICE:          return "PING_SERVICE";
        case MEMBERSHIP_SERVICE:    return "MEMBERSHIP_SERVICE";
        default:                    return "INVALID_SERVICE";
    }
}

/**
 * Given an Opcode, return a human-readable string containing
 * the symbolic name for the opcode, such as "PING"
 *
 * \param opcode
 *      Identifies the operation requested in an RPC; must be one
 *      of the values defined for Opcode
 *
 * \return
 *      See above.
 */
const char*
opcodeSymbol(uint32_t opcode)
{
    switch (opcode) {
        case PING:                       return "PING";
        case PROXY_PING:                 return "PROXY_PING";
        case KILL:                       return "KILL";
        case CREATE_TABLE:               return "CREATE_TABLE";
        case GET_TABLE_ID:               return "GET_TABLE_ID";
        case DROP_TABLE:                 return "DROP_TABLE";
        case READ:                       return "READ";
        case WRITE:                      return "WRITE";
        case REMOVE:                     return "REMOVE";
        case ENLIST_SERVER:              return "ENLIST_SERVER";
        case GET_SERVER_LIST:            return "GET_SERVER_LIST";
        case GET_TABLET_MAP:             return "GET_TABLET_MAP";
        case RECOVER:                    return "RECOVER";
        case HINT_SERVER_DOWN:           return "HINT_SERVER_DOWN";
        case RECOVERY_MASTER_FINISHED:   return "RECOVERY_MASTER_FINISHED";
        case ENUMERATION:                return "ENUMERATION";
        case FILL_WITH_TEST_DATA:        return "FILL_WITH_TEST_DATA";
        case MULTI_READ:                 return "MULTI_READ";
        case GET_METRICS:                return "GET_METRICS";
        case BACKUP_CLOSE:               return "BACKUP_CLOSE";
        case BACKUP_FREE:                return "BACKUP_FREE";
        case BACKUP_GETRECOVERYDATA:     return "BACKUP_GETRECOVERYDATA";
        case BACKUP_OPEN:                return "BACKUP_OPEN";
        case BACKUP_STARTREADINGDATA:    return "BACKUP_STARTREADINGDATA";
        case BACKUP_WRITE:               return "BACKUP_WRITE";
        case BACKUP_RECOVERYCOMPLETE:    return "BACKUP_RECOVERYCOMPLETE";
        case BACKUP_QUIESCE:             return "BACKUP_QUIESCE";
        case SET_SERVER_LIST:            return "SET_SERVER_LIST";
        case UPDATE_SERVER_LIST:         return "UPDATE_SERVER_LIST";
        case SEND_SERVER_LIST:           return "SEND_SERVER_LIST";
        case GET_SERVER_ID:              return "GET_SERVER_ID";
        case SET_MIN_OPEN_SEGMENT_ID:    return "SET_MIN_OPEN_SEGMENT_ID";
        case DROP_TABLET_OWNERSHIP:      return "DROP_TABLET_OWNERSHIP";
        case TAKE_TABLET_OWNERSHIP:      return "TAKE_TABLET_OWNERSHIP";
        case BACKUP_ASSIGN_GROUP:        return "BACKUP_ASSIGN_GROUP";
        case INCREMENT:                  return "INCREMENT";
        case GET_HEAD_OF_LOG:            return "GET_HEAD_OF_LOG";
        case PREP_FOR_MIGRATION:         return "PREP_FOR_MIGRATION";
        case RECEIVE_MIGRATION_DATA:     return "RECEIVE_MIGRATION_DATA";
        case REASSIGN_TABLET_OWNERSHIP:  return "REASSIGN_TABLET_OWNERSHIP";
        case MIGRATE_TABLET:             return "MIGRATE_TABLET";
        case IS_REPLICA_NEEDED:          return "IS_REPLICA_NEEDED";
        case SPLIT_TABLET:               return "SPLIT_TABLET";
        case GET_SERVER_STATISTICS:      return "GET_SERVER_STATISTICS";
        case SET_RUNTIME_OPTION:         return "SET_RUNTIME_OPTION";
        case ILLEGAL_RPC_TYPE:           return "ILLEGAL_RPC_TYPE";
    }

    // Never heard of this RPC; return the numeric value. The shared buffer
    // below isn't thread-safe, but the worst that will happen is that the
    // return value will get garbled, and this code should never be executed
    // in a production system anyway.

    static char symbol[50];
    snprintf(symbol, sizeof(symbol), "unknown(%d)", opcode);
    return symbol;
}


/**
 * Given a buffer containing an RPC request, return a human-readable string
 * containing the symbolic name for the request's opcode, such as "PING".
 *
 * \param buffer
 *      Must contain a well-formed RPC request.
 *
 * \return
 *      A symbolic name for the request's opcode.
 */
const char*
opcodeSymbol(Buffer& buffer)
{
    const RequestCommon* header = buffer.getStart<RequestCommon>();
    if (header == NULL)
        return "null";
    return opcodeSymbol(header->opcode);
}
/**
 * Equality for RecoverRpc::Replica, useful for unit tests.
 */
bool
operator==(const Recover::Replica& a, const Recover::Replica& b)
{
    return (a.backupId == b.backupId &&
            a.segmentId == b.segmentId);
}

/**
 * Inequality for RecoverRpc::Replica, useful for unit tests.
 */
bool
operator!=(const Recover::Replica& a, const Recover::Replica& b)
{
    return !(a == b);
}

/**
 * String representation of Recover::Replica, useful for unit tests.
 */
std::ostream&
operator<<(std::ostream& stream, const Recover::Replica& replica) {
    stream << "Replica(backupId=" << replica.backupId
           << ", segmentId=" << replica.segmentId
           << ")";
    return stream;
}

}  // namespace WireFormat
}  // namespace RAMCloud