page 50033 "Member S/Dep. Account List"
{
    // version TL2.0

    Caption = 'Member Saving/Deposit Accounts';
    CardPageID = "Member S/Dep. Account Card";
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = WHERE("Vendor Type" = FILTER(Fosa));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Caption = 'Posting Group';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("Withheld Sep10th 2024 Balance"; Rec."Withheld Sep10th 2024 Balance")
                {
                    ApplicationArea = All;
                }
                field("Deposits From Sep10th 2024 Balance"; Rec."Deposits From Sep10th 2024 Balance")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    actions
    {
        area(Reporting)
        {
            group(Reports)
            {

                action(Statement)
                {
                    Image = SocialListening;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Vendor.Reset();
                        If Vendor.FindSet() then begin
                            repeat
                                Vendor."Member No." := CopyStr(Vendor."No.", 7, 10);
                                Vendor.Modify();
                            until Vendor.Next = 0;
                        end;
                        /*Vendor.FILTERGROUP(10);
                        Vendor.SETRANGE("Member No.", Rec."Member No.");
                        Vendor.SetRange("No.", Rec."No.");
                        Vendor.FILTERGROUP(0);
                        Report.RUN(50082, true, false, Vendor);*/
                    end;
                }



            }

        }
    }

    trigger OnAfterGetRecord()
    var
        Memb: Record Member;
    begin
        If Memb.Get(Rec."Member No.") then begin
            if Rec."Global Dimension 1 Code" = '' then begin
                Rec."Global Dimension 1 Code" := Memb."Global Dimension 1 Code";
                Rec.Modify();
            end;
        end;
    end;

    var
        Vendor: Record "Vendor";
        Customer: Record "Customer";

}
