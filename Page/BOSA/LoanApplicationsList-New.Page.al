page 50204 "Loan Application List-New"
{
    // version TL2.0

    Caption = 'New Loan Applications';
    CardPageID = "Loan Application Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Security,Approval Request,Category 6,Category 7,Category 8';
    SourceTable = "Loan Application";
    SourceTableView = WHERE(Status = CONST(New));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Caption = 'Loan Product';
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer"; Rec."Loan Officer")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetActionVisible;
        CurrPage.Editable(false);
        Rec.SetFilter("Created By", UserId);
    end;

    var
        LoanGuarantor: Record "Loan Guarantor";
        LoanCollateral: Record "Loan Collateral";
        //LoanOffset: Record "loan off";
        IsVisibleSendApprovalRequest: Boolean;
        IsVisibleCancelApprovalRequest: Boolean;

    local procedure SetActionVisible()
    begin
        /*
        IF ("FOSA Account"="FOSA Account"::"0")THEN BEGIN
            IsVisibleSendApprovalRequest:=TRUE;
            IsVisibleCancelApprovalRequest:=TRUE;
        END ELSE BEGIN
          IsVisibleSendApprovalRequest:=FALSE;
          IsVisibleCancelApprovalRequest:=FALSE;
        END;
        */

    end;
}

