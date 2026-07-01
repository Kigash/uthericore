tableextension 50015 GeneralJournalLineExt extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        modify("Account No.")
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            else
            IF ("Member No" = filter(''), "Account Type" = CONST(Customer)) Customer
            else
            IF ("Member No" = filter(''), "Account Type" = CONST(Vendor)) Vendor
            else
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            else
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            else
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            else
            IF ("Account Type" = CONST(Employee)) Employee
            else
            if ("Member No" = filter(<> ''), "Account Type" = CONST(Customer)) "Loan Application" where(Posted = filter(true), "Member No." = field("Member No"))
            else
            if ("Member No" = filter(<> ''), "Account Type" = CONST(Vendor)) Vendor where("Member No." = field("Member No"));
        }
        field(50000; "Transaction Type Code"; Code[20])
        {
            TableRelation = "Transaction Type";
            trigger OnValidate()
            var
                TransCodeSetup: Record "Transaction Type Code Setup";
                LProd: Record "Loan Product Type";
                Cust: Record Customer;
            begin
                TransCodeSetup.Get();
                if ("Account Type" = "Account Type"::Customer) /*and ("Member No" <> '')*/ then begin
                    if "Account No." <> '' then begin
                        If Cust.Get("Account No.") then begin
                            LProd.Get(Cust."Customer Posting Group");
                            if ("Transaction Type Code" = TransCodeSetup."Interest Due") or ("Transaction Type Code" = TransCodeSetup."Interest Paid") then begin
                                // Message('Posting Group %1', LProd."Interest Due Posting Group");
                                "Posting Group" := LProd."Interest Due Posting Group";
                                Modify();
                            end;
                            if ("Transaction Type Code" = TransCodeSetup."Penalty Due") or ("Transaction Type Code" = TransCodeSetup."Penalty Paid") then begin
                                "Posting Group" := LProd."Penalty Due Posting Group";
                                Modify();
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(50001; "Member No"; Code[20])
        {
            TableRelation = Member;
            trigger OnValidate()
            begin
                if "Member No" <> '' then begin

                end;
            end;

        }
        field(50002; "Account No. 2"; code[20])
        {
            Caption = 'Member Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            else
            IF ("Member No" = filter(''), "Account Type" = CONST(Customer)) Customer
            else
            IF ("Member No" = filter(''), "Account Type" = CONST(Vendor)) Vendor
            else
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            else
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            else
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            else
            IF ("Account Type" = CONST(Employee)) Employee
            else
            if ("Member No" = filter(<> ''), "Account Type" = CONST(Customer)) "Loan Application" where(Posted = filter(true), "Member No." = field("Member No"))
            else
            if ("Member No" = filter(<> ''), "Account Type" = CONST(Vendor)) Vendor where("Member No." = field("Member No"));
        }
    }

    var
        myInt: Integer;
}