page 50016 "Account Type List"
{
    // version TL2.0

    Caption = 'Account Types';
    CardPageID = "Account Type Card";
    PageType = List;
    SourceTable = "Account Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ledger Fee"; Rec."Ledger Fee")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allow Withdrawal"; Rec."Allow Withdrawal")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allow Deposit"; Rec."Allow Deposit")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Earns Interest"; Rec."Earns Interest")
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }

                field("Open Automatically"; Rec."Open Automatically")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }
}

