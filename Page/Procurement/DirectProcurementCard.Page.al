page 50809 "Direct Procurement Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Procurement Request";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No."; Rec."Procurement Plan No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assigned User"; Rec."Assigned User")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("LPO Generated"; Rec."LPO Generated")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("LPO No."; Rec."LPO No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Page; "Procurement Request Line")
            {
                Editable = false;
                SubPageLink = "Request No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Purchase Order")
            {
                ApplicationArea = All;
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeGenerate;

                trigger OnAction();
                begin
                    ProcurementManagement.AssignUser(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        ManageVisibility;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Procurement Option" := Rec."Procurement Option"::Direct;
        ManageVisibility;
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        ManageVisibility;
    end;

    trigger OnOpenPage();
    begin
        ManageVisibility;
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        RequisitionLines: Record "Requisition Line";
        SeeGenerate: Boolean;

    local procedure ManageVisibility();
    begin
        SeeGenerate := TRUE;
        IF Rec."LPO Generated" THEN BEGIN
            SeeGenerate := FALSE;
            CurrPage.EDITABLE(FALSE);
        END;
    end;
}

