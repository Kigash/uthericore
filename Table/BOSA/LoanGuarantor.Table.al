table 50105 "Loan Guarantor"
{
    // version TL2.0

    DrillDownPageID = 50210;
    LookupPageID = 50210;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Member No."; Code[20])
        {
            TableRelation = Member;

            trigger OnValidate()
            begin
                //if GuarantorAlreadyUsed() then
                //Error(GuarantorAlreadyUsedErr);

                Member.GET("Member No.");
                "Member Name" := Member."Full Name";
                if (Member.Status = Member.Status::Active) or (Member.Status = Member.Status::Dormant) then begin
                    "Account No." := FosaM.GetSavingsMemberAccount(Member);
                    /*IF Vendor.GET("Account No.") THEN
                        "Account Name" := Vendor.Name;
                    "Other Guaranteed Amount" := BOSAManagement.CalculateOtherGuaranteedAmount("Member No.", "Loan No.");
                    "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, "Account No.");
                    "Net Account Balance" := "Account Balance" - "Other Guaranteed Amount";
                    IF "Net Account Balance" <= 0 THEN
                        "Net Account Balance" := 0;*/

                    CASE Member.Category OF
                        Member.Category::Individual:
                            begin
                                AccountType.Reset();
                                AccountType.SetRange(Type, AccountType.Type::Savings);
                                AccountType.SetRange("Sub Type", AccountType."Sub Type"::Ordinary);
                            end;

                        Member.Category::Group:
                            begin
                                AccountType.Reset();
                                AccountType.SetRange("Can Guarantee Loan", true);
                            end;

                        else begin
                            AccountType.Reset();
                            AccountType.SetRange("Can Guarantee Loan", true);
                        end;
                    END;

                    if AccountType.FindSet() then begin
                        repeat
                            Vendor.Reset();
                            Vendor.SetRange("Account Type", AccountType.Code);
                            Vendor.SetRange("Member No.", Rec."Member No.");

                            if Vendor.FindFirst() then begin
                                "Account No." := Vendor."No.";
                                "Account Name" := Vendor.Name;

                                "Other Guaranteed Amount" := BOSAManagement.CalculateOtherGuaranteedAmount("Member No.", "Loan No.");
                                "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, "Account No.");
                                "Net Account Balance" := "Account Balance" - "Other Guaranteed Amount";
                                IF "Net Account Balance" <= 0 THEN
                                    "Net Account Balance" := 0;
                                break;
                            end;

                        until AccountType.Next() = 0;
                    end;


                    /* AccountType.Reset();
                    AccountType.SetRange(Type, AccountType.Type::"Member Deposit");
                    if AccountType.FindFirst() then begin
                        Vendor.Reset();
                        Vendor.SetRange("Account Type", AccountType.Code);
                        Vendor.SetRange("Member No.", Rec."Member No.");
                        IF Vendor.Findfirst() THEN BEGIN
                            "Account No." := Vendor."No.";
                            "Account Name" := Vendor.Name;

                            "Other Guaranteed Amount" := BOSAManagement.CalculateOtherGuaranteedAmount("Member No.", "Loan No.");
                            "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, "Account No.");
                            "Net Account Balance" := "Account Balance" - "Other Guaranteed Amount";
                            IF "Net Account Balance" <= 0 THEN
                                "Net Account Balance" := 0;
                        END;
                    end; */
                end else
                    Error('Current Member Status is %1', Member.Status);
            end;
        }
        field(4; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(5; "Account No."; Code[20])
        {
            Editable = false;
            TableRelation = Vendor WHERE("Member No." = FIELD("Member No."));

            trigger OnValidate()
            begin
                IF Vendor.GET("Account No.") THEN BEGIN
                    AccountType.Get(Vendor."Account Type");
                    if not AccountType."Can Guarantee Loan" then
                        Error(AccountNotAllowedErr, AccountType.Type);
                    "Account Name" := Vendor.Name;
                    "Other Guaranteed Amount" := BOSAManagement.CalculateOtherGuaranteedAmount("Member No.", "Loan No.");
                    "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, "Account No.");
                    "Net Account Balance" := "Account Balance" - "Other Guaranteed Amount";
                    IF "Net Account Balance" <= 0 THEN
                        "Net Account Balance" := 0;
                END;
            end;
        }
        field(6; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(7; "Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(8; "Other Guaranteed Amount"; Decimal)
        {
            Editable = false;
        }
        field(9; "Net Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(10; "Amount To Guarantee"; Decimal)
        {

            trigger OnValidate()
            var
                LGuar: Record "Loan Guarantor";
                Loan: Record "Loan Application";
            begin
                /*IF "Amount To Guarantee" > "Net Account Balance" THEN
                    ERROR(Error000, FIELDCAPTION("Amount To Guarantee"), FIELDCAPTION("Net Account Balance"));
                //----------------------Update Guarantor ratio--------------------------------------------
                 Clear("Guarantor Ratio");

                 if Loan.Get("Loan No.") then begin
                     LGuar.Reset();
                     LGuar.SetRange(LGuar."Loan No.", Loan."No.");
                     if LGuar.FindSet() then begin
                         repeat
                             Message('Ration =%1', LGuar."Amount To Guarantee" / Loan."Requested Amount");
                             LGuar."Guarantor Ratio" := LGuar."Amount To Guarantee" / Loan."Requested Amount";
                             LGuar.Modify;
                             Commit();
                         until LGuar.Next = 0;
                     end;
                 end;*/
                //----------------------End Update Guarantor ratio--------------------------------------------
            end;
        }
        field(11; "Guarantor Ratio"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
    /* trigger OnInsert()
     begin
         LoanApplication.Get("Loan No.");
         LoanApplication.TestField(Status, LoanApplication.Status::New);
     end;

     trigger OnModify()
     begin
         LoanApplication.Get("Loan No.");
         LoanApplication.TestField(Status, LoanApplication.Status::New);
     end;

     trigger OnDelete()
     begin
         LoanApplication.Get("Loan No.");
         LoanApplication.TestField(Status, LoanApplication.Status::New);
     end;
 */
    local procedure GuarantorAlreadyUsed(): Boolean
    var

    begin
        LoanGuarantor.Reset();
        LoanGuarantor.SetRange("Member No.", "Member No.");
        LoanGuarantor.SetFilter("Loan No.", '<>%1', "Loan No.");
        exit(LoanGuarantor.FindFirst());
    end;

    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountType: Record "Account Type";
        LoanGuarantor: Record "Loan Guarantor";
        LoanApplication: Record "Loan Application";
        GlobalManagement: Codeunit "Global Management";
        Error000: Label '%1 cannot exceed %2';
        Error001: Label 'This account has insufficient balance';
        AccountNotAllowedErr: Label '%1 is not allowed';
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        BOSAManagement: Codeunit "BOSA Management";
        FosaM: Codeunit "FOSA Management";
        GuarantorAlreadyUsedErr: Label 'This guarantor is already used to guarantee another loan';


}

