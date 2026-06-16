page 50973 "File Movement Approval Card"
{
    // version TL2.0

    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "File Movement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File Movement ID"; Rec."File Movement ID")
                {
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Cabinet No."; Rec."Cabinet No.")
                {
                    ApplicationArea = All;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    Caption = 'From Branch';
                    Editable = true;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    Caption = 'To Branch';
                    Editable = false;
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    ApplicationArea = All;
                }
                field("Approval/Rejection Remarks"; Rec."Approval/Rejection Remarks")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Approver ID" := USERID;
                        Rec."Approved Date" := CURRENTDATETIME;
                    end;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Approve Request")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.ApproveFileTransfer(Rec);
                end;
            }
            action("Reject Request")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.RejectFileTransfer(Rec);
                end;
            }
        }
    }

    var
        User: Record "User Setup";
        RegistryManagement: Codeunit "Registry Management2";
}

