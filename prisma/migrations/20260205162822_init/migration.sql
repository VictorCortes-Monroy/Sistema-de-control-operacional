-- CreateTable
CREATE TABLE "Worker" (
    "worker_id" TEXT NOT NULL PRIMARY KEY,
    "rut" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    "updated_at" DATETIME NOT NULL,
    "updated_by_user_id" TEXT,
    CONSTRAINT "Worker_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Worker_updated_by_user_id_fkey" FOREIGN KEY ("updated_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UserAccount" (
    "user_id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "WorkerEmployment" (
    "employment_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "contract_type" TEXT NOT NULL,
    "hire_date" DATETIME NOT NULL,
    "termination_date" DATETIME,
    "status" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    CONSTRAINT "WorkerEmployment_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "WorkerEmployment_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "WorkerUnionMembership" (
    "union_membership_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "union_name" TEXT NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    CONSTRAINT "WorkerUnionMembership_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "WorkerUnionMembership_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ShiftGroup" (
    "shift_group_id" TEXT NOT NULL PRIMARY KEY,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cycle_days" INTEGER NOT NULL DEFAULT 10
);

-- CreateTable
CREATE TABLE "ShiftCycleCalendar" (
    "cal_id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "active_shift_group_id" TEXT NOT NULL,
    "cycle_number" INTEGER NOT NULL,
    "cycle_day" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    CONSTRAINT "ShiftCycleCalendar_active_shift_group_id_fkey" FOREIGN KEY ("active_shift_group_id") REFERENCES "ShiftGroup" ("shift_group_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ShiftCycleCalendar_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "WorkerShiftAssignment" (
    "assignment_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "shift_group_id" TEXT NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME,
    "reason" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    CONSTRAINT "WorkerShiftAssignment_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "WorkerShiftAssignment_shift_group_id_fkey" FOREIGN KEY ("shift_group_id") REFERENCES "ShiftGroup" ("shift_group_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "WorkerShiftAssignment_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "LeaveType" (
    "leave_type_id" TEXT NOT NULL PRIMARY KEY,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "blocks_attendance" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "LeaveRequest" (
    "leave_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "leave_type_id" TEXT NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME NOT NULL,
    "status" TEXT NOT NULL,
    "document_ref" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    CONSTRAINT "LeaveRequest_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "LeaveRequest_leave_type_id_fkey" FOREIGN KEY ("leave_type_id") REFERENCES "LeaveType" ("leave_type_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "LeaveRequest_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PermissionRequest" (
    "permission_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "reason" TEXT,
    "status" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    CONSTRAINT "PermissionRequest_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PermissionRequest_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "AttendanceMark" (
    "mark_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "timestamp" DATETIME NOT NULL,
    "mark_type" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "captured_by_user_id" TEXT,
    "note" TEXT,
    CONSTRAINT "AttendanceMark_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AttendanceMark_captured_by_user_id_fkey" FOREIGN KEY ("captured_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "AttendanceDaily" (
    "attendance_daily_id" TEXT NOT NULL PRIMARY KEY,
    "worker_id" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "shift_group_id" TEXT,
    "status" TEXT NOT NULL,
    "status_reason" TEXT,
    "source" TEXT NOT NULL,
    "locked" BOOLEAN NOT NULL DEFAULT false,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_user_id" TEXT,
    "updated_at" DATETIME NOT NULL,
    "updated_by_user_id" TEXT,
    CONSTRAINT "AttendanceDaily_worker_id_fkey" FOREIGN KEY ("worker_id") REFERENCES "Worker" ("worker_id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AttendanceDaily_shift_group_id_fkey" FOREIGN KEY ("shift_group_id") REFERENCES "ShiftGroup" ("shift_group_id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "AttendanceDaily_created_by_user_id_fkey" FOREIGN KEY ("created_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "AttendanceDaily_updated_by_user_id_fkey" FOREIGN KEY ("updated_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "audit_id" TEXT NOT NULL PRIMARY KEY,
    "entity_name" TEXT NOT NULL,
    "entity_id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "changed_by_user_id" TEXT,
    "changed_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "diff_json" TEXT,
    CONSTRAINT "AuditLog_changed_by_user_id_fkey" FOREIGN KEY ("changed_by_user_id") REFERENCES "UserAccount" ("user_id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Worker_rut_key" ON "Worker"("rut");

-- CreateIndex
CREATE UNIQUE INDEX "UserAccount_email_key" ON "UserAccount"("email");

-- CreateIndex
CREATE UNIQUE INDEX "ShiftGroup_code_key" ON "ShiftGroup"("code");

-- CreateIndex
CREATE UNIQUE INDEX "ShiftCycleCalendar_date_key" ON "ShiftCycleCalendar"("date");

-- CreateIndex
CREATE UNIQUE INDEX "LeaveType_code_key" ON "LeaveType"("code");
