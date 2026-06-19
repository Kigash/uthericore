table 50168 "BOSA Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[250])
        {

            DataClassification = ToBeClassified;
        }
        field(2; "LoanApplication-New"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Application" where(Status = FILTER(New)));

        }

        field(3; "LoanApplication-Pending"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Application" where(Status = FILTER("Pending Approval")));

        }
        field(4; "LoanApplication-Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Application" where(Status = FILTER(Approved), Posted = filter(false)));

        }
        field(5; "LoanApplication-Rejected"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Application" where(Status = FILTER(Rejected)));

        }
        field(6; "LoanApplication-Posted"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Application" where(Status = FILTER(Approved), Posted = filter(true)));

        }
        field(7; "Total Requested Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loan Application"."Requested Amount" where(Status = FILTER(Approved), Posted = filter(true)));

        }
        field(8; "Total Disbursed Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loan Application"."Approved Amount" where(Status = FILTER(Approved), Posted = filter(true)));

        }
        field(12; "StandingOrder-New"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Standing Order" where(Status = FILTER(New)));

        }

        field(13; "StandingOrder-Pending"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Standing Order" where(Status = FILTER("Pending Approval")));

        }
        field(14; "StandingOrder-Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Standing Order" where(Status = FILTER(Approved), running = filter(false)));

        }
        field(15; "StandingOrder-Rejected"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Standing Order" where(Status = FILTER(Rejected)));

        }
        field(16; "StandingOrder-Running"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Standing Order" where(Status = FILTER(Approved), Running = filter(true)));

        }
        field(17; "Member-Active"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Member where("Dormancy Status" = FILTER(Active)));

        }

        field(18; "Member-Dormant"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Member where("Dormancy Status" = FILTER(Dormant)));

        }
        field(19; "Member-Suspended"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Member where(Status = FILTER(Suspended)));

        }
        field(20; "Member-Withdrawn"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Member where(Status = FILTER(Withdrawn)));

        }
        field(21; "MobileBankingMember-Active"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Mobile Banking Member" where(Status = FILTER(Active)));

        }
        field(22; "MobileBankingMember-Inactive"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Mobile Banking Member" where(Status = FILTER(Inactive)));

        }

    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}